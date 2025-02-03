totalx = 100;
deltax = 0.5;
numx = totalx/deltax+1;
x = zeros(numx,1);

for t=1:numx-1
    x(t+1) = x(t)+deltax;
end

infun = @(u) 2/sqrt(pi)*exp(-u.^2);
erf1 = @(x) integral(infun,0,x);

% erf2: An array that b is assigned to erf1
erf2 = arrayfun(erf1,x);

tanh = @(x) (exp(x)-exp(-x))./(exp(x)+exp(-x));

f1 = 1/2*(1+erf2);
f2 = 1/2*(1+tanh(x));


hold on
plot(x,f1);plot(x,f2);
hold off
xlabel('x'); ylabel('y')
title('1/2(1+erfx) VS 1/2(1+tanhx)')
legend('1/2(1+erfx)','1/2(1+tanhx)')

