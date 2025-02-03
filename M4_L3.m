%%%% M4_L3 problem #1

V = zeros(101,1);
alpha_m = zeros(101,1);
alpha_h = zeros(101,1);
beta_m = zeros(101,1);
beta_h = zeros(101,1);

for i=1:101
    V(i) = i-101;

    alpha_m(i) = 0.1*(V(i)+40)/(1-exp(-0.1*(V(i)+40)));
    beta_m(i) = 4*exp(-0.0556*(V(i)+65));

    alpha_h(i) = 0.07*exp(-0.05*(V(i)+65));
    beta_h(i) = 1/(1+exp(-0.1*(V(i)+35)));
end

subplot(2,2,1)
plot(V, alpha_m)
xlabel('V (mV)'); ylabel('alpha (ms-1)');
title('alpha_m')

subplot(2,2,2)
plot(V, beta_m)
xlabel('V (mV)'); ylabel('beta (ms-1)');
title('beta_m')

subplot(2,2,3)
plot(V, alpha_h)
xlabel('V (mV)'); ylabel('alpha (ms-1)');
title('alpha_h')

subplot(2,2,4)
plot(V, beta_h)
xlabel('V (mV)'); ylabel('beta (ms-1)');
title('beta_h')


