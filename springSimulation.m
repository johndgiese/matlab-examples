%%Set Initial Positions and Velocities

x = [.5 2];
v = [0 .3];

%System Parameters
x0 = [1 2]; %resting positions
k  = [1 1]; %spring constants
m  = [1 1];
damping = [0 0];
dt = .001;
tFinal = 40;

X = double(zeros(2,ceil(tFinal/dt + 1)));
V = double(zeros(2,ceil(tFinal/dt + 1)));
t = 0:dt:tFinal;

%Solve Difference Equations
counter = 1;
for i = 0:dt:tFinal
    X(:,counter) = x;
    V(:,counter) = v;
    counter = counter + 1;
    
    a(1) = -k(1)/m(1)*(x(1) - x0(1)) ...
           +k(2)/m(1)*((x(2) - x(1)) - (x0(2) - x0(1)));
    a(2) = -k(2)/m(2)*((x(2) - x(1)) - (x0(2) - x0(1)));
    a = a - damping.*v;
    
    v = v + a*dt;
    x = x + v*dt;
end

%Plot results
hold on
axis([0 tFinal 0 3]);
plot(t,X(1,:));
plot(t,X(2,:),'r');
hold off