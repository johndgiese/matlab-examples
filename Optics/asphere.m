diameter = 4.95; % [mm]
zvtov = 2.94; % surface1 to surface 2 vertex-to-vertex distance [mm]

% side 1
R_1 = 2.96; % Radius of Curvature [mm]
k_1 = -0.3552361; % Conic Constant [-]
a2_1 = 0; % 2nd order aspheric constant [mm^-1]
a4_1 = 0.0013285109; % 4th order aspheric constant [mm^-3]
a6_1 = 0.00013974549; % 6th order aspheric constant [mm^-5]
a8_1 = 0.0000037686018; % 8th order aspheric constant [mm^-7]
a10_1 = 0.000001012969; % 10th order aspheric constant [mm^-9]

% side 2
R_2 = -18.73; % Radius of Curvature [mm]
k_2 = 0; % Conic Constant [-]
a2_2 = 0; % 2nd order aspheric constant [mm^-1]
a4_2 = 0; % 4th order aspheric constant [mm^-3]
a6_2 = 0; % 6th order aspheric constant [mm^-5]
a8_2 = 0; % 8th order aspheric constant [mm^-7]
a10_2 = 0; % 10th order aspheric constant [mm^-9]

Ny = 1000;
y = linspace(0,diameter/2,Ny);

z1 = y.^2./(R_1*(1+sqrt(1-(1+k_1)*y.^2/R_1^2))) + a2_1*y.^2 + ...
    a4_1*y.^4 + a6_1*y.^6 + a8_1*y.^8 + a10_1*y.^10;
z1 = [fliplr(z1(2:end)) z1];

z2 = y.^2./(R_2*(1+sqrt(1-(1+k_2)*y.^2/R_2^2))) + a2_2*y.^2 + ...
    a4_2*y.^4 + a6_2*y.^6 + a8_2*y.^8 + a10_2*y.^10;
z2 = [fliplr(z2(2:end)) z2];
y = [-fliplr(y(2:end)) y];

figure;
plot(z1,y,'k',z2+zvtov,y,'k');
axis square;