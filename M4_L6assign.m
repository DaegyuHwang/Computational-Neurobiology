% C = 1 nF = 1000 pF
Rm = 20;
VL = -65;
C = 1;
tau = 20;

% time
totalt = 100;
deltat = 0.5;
numtime = totalt/deltat+1;
timearray = zeros(numtime,1);

% about spike
V_spk = -45;
V_reset = -60;
t_arp = 2;
n_spk = 0;
n_t = zeros(numtime,1);
V = zeros(numtime,1);
lambda = 1.3;
T = 1/lambda;

% J ; s(t-tj) = (1/tau)*exp^(-(t-tj)/tau)
% J = randi(2,numtime,1)-1;
% J(J==0)=-1;
J=2;

j_n = 0;
s = zeros(numtime*1000,1);



% Initial conditions
V(1) = VL;
for t=1 : numtime-1
    timearray(t+1) = timearray(t)+deltat;
    tj = zeros(numtime*1000, 1);
    if n_spk ~= 0
        tj(1) = timearray(n_t(n_spk))+t_arp/deltat;
        if n_t(n_spk)+t_arp/deltat > t
            V(t+1) = V_reset;      
            continue;
        end
        VL=V_reset; 
    end
    

    for k=1: numtime*1000-1
        if tj(k) <= totalt
            tj(k+1) = tj(k)+T;
            if tj(k)>timearray(t)
                j_n = k-1;
                break
            end
        end
    end
 
    if (t == 1)||(t==tj(1))
        dV_dt = 1/C*(-(V(t)-VL)/Rm);
    else
        for i=1 : j_n
            s(i)= (1/tau)*exp(-(timearray(t)-tj(i))/tau);
        end
        dV_dt = 1/C*(-(V(t)-VL)/Rm+J*sum(s(1:j_n)));
    end
    V(t+1) = V(t) + dV_dt*deltat;
    if V(t+1) >= V_spk
        if V(t) < V_spk
            n_t(n_spk+1) = t+1;
            n_spk = n_spk+1;
            V(t+1) = V_spk;
        end       	
    end
end
sgtitle('Leaky Integrate-and-Fire neuron model')
plot(timearray,V)
xlabel('time (ms)'); ylabel('membrane potential (mV)')
ylim([-70,0])


% after one spike does VL change to V_reset in the differential equations?