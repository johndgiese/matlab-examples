%% Anhormonic Lorentz Model of the Electron

global m w0 e a b gamma E;
m = 9.10938188e-31;
w0 = 2*pi*1e16;
e = 1.6e-19;
gamma = 0.0001;

%% non-centrosymmetric
d = 2e-10;
a = w0^2/d; % nonlinearity

A = 0;
w = w0*1.1;
E = @(t) A*cos(w*t);

options = odeset('RelTol',1e-6,'AbsTol',[1e-6 1e-6]);
[t,x] = ode23(@aofun,[0 20*2*pi/w0],[1e-10 0],options);

plot(t,x(:,1));

%% centrosymmetric
d = 1.4e-10;
b = w0^2/d^2;

A = 0;
w = w0*1.1;
E = @(t) A*cos(w*t);

options = odeset('RelTol',1e-7,'AbsTol',[1e-7 1e-7]);
[t,x] = ode23(@aofunc,[0 1*2*pi/w0],[5e-10 0],options);

plot(t,x(:,1))

%% plot energy function

dx = 1e-12;
Nx = 400;
xgoingup = 0:dx:(Nx*dx)
xgoingdown = -dx:-dx:(-Nx*dx)

E = @(t) 0;

x2u = zeros(size(xgoingup));
for k = 1:length(xgoingup)    
    temp = aofun(0,[xgoingup(k); 0]);
    x2u(k) = temp(2);
end

x2d = zeros(size(xgoingdown));
for k = 1:length(xgoingdown)    
    temp = aofun(0,[xgoingdown(k); 0]);
    x2d(k) = temp(2);
end

x2zero = x2u(1);
x2u = x2u - x2zero;
x2d = x2d - x2zero;

Uu = - cumsum(x2u)*m*dx;
Ud = cumsum(x2d)*m*dx;

U = [fliplr(Ud) Uu];
x = [fliplr(xgoingdown) xgoingup];

plot(x,U);
ylabel('Potential Energy');
xlabel('position');