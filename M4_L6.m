% C = 1 nF = 1000 pF/ Tau(ms) R(MΩ) C(nF)
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


J=1/20*1000;

s = zeros(numtime*1000,1);

% Let I_S = input spike
I_S = zeros(numtime*1000,1);

for k=1: numtime-1
    if I_S(k) <= totalt
        I_S(k+1) = I_S(k)+T;
        if I_S(k+1)>=totalt
            break
        end
    end
end


% Let after_refractory time : A_R
A_R = 0;

V(1) = VL;
for t=1 : numtime-1
    timearray(t+1) = timearray(t)+deltat;
    if n_spk ~= 0
        A_R = timearray(n_t(n_spk))+t_arp;
        if timearray(n_t(n_spk))+t_arp > timearray(t)
            V(t+1) = V_reset;      
            continue;
        end
        VL=V_reset; 
    end
    

    j_start = find(I_S>=A_R,1);
    j_end = find(I_S>timearray(t),1)-1;
    j_num = j_end-j_start+1;
 
    if j_num == 0
        dV_dt = 1/C*(-(V(t)-VL)/Rm);
    else
        for i=1 : j_num
            s(i)= (1/tau)*exp(-(timearray(t)-I_S(i+j_start-1))/tau);
        end
        dV_dt = 1/C*(-(V(t)-VL)/Rm+J*sum(s(1:j_num)));
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


