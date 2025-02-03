

% set the time arbitrarily
totalt = 200;
deltat = 0.01;
numtime = totalt/deltat+1;
timearray = zeros(numtime,1);

r = zeros(numtime,1);
theta = zeros(numtime,1);
z = zeros(numtime,1);

dr_dt = zeros(numtime,1);
dtheta_dt = zeros(numtime,1);
dz_zt = zeros(numtime,1);

% Let I_rh : at least value of input current that arises Rheobase
I_rh = 0;

% let r starts at 2 and theta = 6  
r(1) = 5;
theta(1) = 6;
z(1) = r(1)*cos(theta(1));


n_spk = 0;
z_spk = 0;
n_w = 0;

% let
z_reset = z(1);

for w = 0.8:0.1:1.3

    for t = 1:numtime-1
        timearray(t+1) = timearray(t)+deltat;

        dr_dt(t) = r(t)*(1-r(t)^2);
        dtheta_dt(t) = w - sin(theta(t));
    
        r(t+1) = r(t)+dr_dt(t)*deltat;
        theta(t+1) = theta(t)+ dtheta_dt(t)*deltat;

        dz_zt(t) = r(t)*(1-r(t)^2)*cos(theta(t))+r(t)*(-sin(theta(t)))*(w-sin(theta(t)));    
        z(t+1) = z(t)+dz_zt(t)*deltat;

        if z(t+1) >= z_spk
            if z(t) < z_spk
                n_spk = n_spk+1;
                z(t+1) = z_reset;
            end
        end
    end

    n_w = n_w+1;

    figure(1)
    sgtitle('SNIC bifurcation')
    subplot(6,1,n_w)
    plot(timearray,z)
    xlabel('time'); ylabel('Z')
    title(w)      
end

