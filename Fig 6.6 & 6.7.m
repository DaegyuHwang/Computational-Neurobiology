% simulation of LIF neuron driven by a spike train
%
% this code shows the simulation of Figs 6.6 and 6.7 of Computational 
% Neuroscience Lecture Notes for AMS 332 by professor G.LaCamera
%
% 'delta_input=positive real number' to use delta input spikes, otherwise
% an exponential postsynaptic current is used. 
% the first case, you do not multiply by 'dt' in the Euler algorithm.
%
% isi_1 represents the regular interspike interval depends on the firing
% rate and isi_2 represents the random interspike interval depnes on the
% poisson process with lambda = firing rate.
%
%
% David Hwang, August 2024


%%%%%%%%%%%%%%%%%%%%%%%%%%
%% main parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%

totalt = 100; % total simulation time (ms)
dt = 0.1; % discrete time step (ms)
VL = -65; % resting potential value (mV)
V1 = VL; % V1 is a number; VL is the initial condition
V2 = VL; % V2 is a number; VL is the initial condition
Vr = -60; % reset potential value (mV)
Vspk = -45; % spike threshold value (mV)
Rm = 20; % membrane resistance (MOhm)
C = 1; % (nF)
tau = 20; % tau = C*Rm (ms)
taus = 1; % synaptic time constant (ms)
tarp = 2; % refractory period (ms)
refr1 = -1; % counts time until the end of the refractory period (ms)
refr2 = -1; % counts time until the end of the refractory period (ms)
Jhat = 1; % postsynaptic current after a spike %J_hat = Rm*J (mV)


%%%%%%%%%%%%%%%%%%%%%%%%%%
%% input spike train
%%%%%%%%%%%%%%%%%%%%%%%%%%

lambda = 1300; % firing rate (spikes/s) = ((spikes/1000)/ms)
timev = 0:dt:totalt; % time vector

% regular interspike interval
isi_1 = repmat((1000/lambda),100000,1); % interval per one spike

% random interspike interval (poisson process)
numspike = totalt*(lambda/1000)*100; % the maximum number of spikes for just in case
isi_2 = -log(rand(numspike,1))/(lambda/1000);

% build vector of 0/1 (0 = no spike in this time bin, 1 = a spike in this time bin)
spkt1 = cumsum(isi_1); % input spike train of regular isi (ms)
spkt2 = cumsum(isi_2); % input spike train of random isi (ms)
tf1 = histc(spkt1,timev); % extract binary (0/1) representation of input spike per each time bin for isi_1
tf2 = histc(spkt2,timev); % extract binary (0/1) representation of input spike per each time bin for isi_2


%%%%%%%%%%%%%%%%%%%%%%%%%%
%% simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_input = 0; % You can choose what kind of post-synaptic current 
Inc = 0; % constant input current (nA)
sim1 = zeros(length(timev),1); % vector to store the values of V1 during simulation
sim2 = zeros(length(timev),1); % vector to store the values of V2 during simulation
k = 0; % counter
n1 = 0; % counter
n2 = 0; % counter 

for t=timev
    k=k+1;

    % main eqution
    if delta_input 
        V1 = V1 + 1/C*((-(V1-VL)/Rm+Inc)*dt+Jhat*tf1(k)); % NOTE: there is no 'dt' factor to multiply the last term (delta input) 
        V2 = V2 + 1/C*((-(V2-VL)/Rm+Inc)*dt+Jhat*tf2(k));         
    else
        V1 = V1 + 1/C*(-(V1-VL)/Rm+Inc+Jhat/taus*sum(exp(-(t-spkt1(1:sum(tf1(1:k)))/taus))))*dt;
        V2 = V2 + 1/C*(-(V2-VL)/Rm+Inc+Jhat/taus*sum(exp(-(t-spkt2(1:sum(tf2(1:k)))/taus))))*dt;
    end
    
    % rest the membrane potential after a spike & define the refractory period
    if refr1>=0 V1=Vr; refr1=refr1-dt; end
    if refr2>=0 V2=Vr; refr2=refr2-dt; end
    
    % define spike threshold
    if V1>Vspk V1=0;refr1=tarp; end
    if V2>Vspk V2=0;refr2=tarp; end

    % store value of V1&V2 for plotting
    sim1(k)=V1;
    sim2(k)=V2;end


%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plots
%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1); clf
sgtitle('Leaky Integrate-and-Fire neuron model','FontWeight','normal')
subplot(2,1,1)  
plot(timev,sim1,'k','LineWidth',1)
xlabel('time (ms)');ylabel('V (mV)');
xlim([0,100]);ylim([-70,0]);
title('Using regular interspike interval')
subplot(2,1,2)
plot(timev,sim2,'k','LineWidth',1)
xlabel('time (ms)');ylabel('V (mV)');
xlim([0,100]);ylim([-70,0]);
title('Using random interspike interval')














