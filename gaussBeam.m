%% Given Radius of Curv at 2 points, find waist position (z1) and depth of
%% field (2*z0)

z1 = @(R1,R2,d) -d*(R2-d)./(R2-R1-2*d);
z0 = @(R1,R2,d) sqrt(-d*(R1+d).*(R2-d).*(R2-R1-d)./(R2-R1-2*d).^2);

d = 1;
r1 = -linspace(1,1000,400);
r2 = 100;
[R1 R2] = meshgrid(r1,r2);

Z1 = z1(R1,R2,d);
Z0 = z0(R1,R2,d);

plot(-R1'/r2,-Z1'/d);
xlabel('R1/R1');
ylabel('z1/d');
title('Gaussian Beam Waist Position as a Function of its Curvature at Two Points');

%% Lens Transformation
f = 1;
z0 = 1;
z = linspace(0,.2,400) + eps();


Mr = @(f,z)abs(f./(z-f));
M = @(f,z,z0) abs(f./(z-f))./sqrt(1+(z0./(z-f)));

plot(z,Mr(f,z));
xlabel('z');
hold on;
plot(z,M(f,z,z0),'r');
legend('M_r','M');
hold off;
title('f = 1, z0 = 1');

