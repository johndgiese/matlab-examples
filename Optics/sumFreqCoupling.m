%% This simulation demonstrates wave coupling

global dk g;

n = 1;
n1 = 1;
n2 = 1;
n3 = 1;

c = 3e8;
eta0 = 377; 
hbar = 1.05457e-34;
eta = eta0/n;

lambda1 = 400e-9;
lambda2 = 200e-9;

w1 = 2*pi*c/lambda1; w2 = 2*pi*c/lambda2;
w3 = w1 + w2;
k1 = n1*2*pi/lambda1; k2 = n2*2*pi/lambda2; k3 = n3*w3/c;

deff = 2e-21;
g = sqrt(2*hbar*w1*w2*w3*eta^3*deff^2);

dk = k3 - k1 - k2;

a0 = [0.4e10; .1e10; 0.2e10];

options = odeset('RelTol',1e-8);
[Z A] = ode23(@sumFreqCouplingFun,[0 4],a0);

I1 = abs(A(:,1)).^2*hbar*w1;
I2 = abs(A(:,2)).^2*hbar*w2;
I3 = abs(A(:,3)).^2*hbar*w3;

plot(Z,I1,Z,I2,Z,I3,Z,I1+I2+I3);
legend('wave 1','wave 2','wave 3','sum')
xlabel('z');
ylabel('Intensity');