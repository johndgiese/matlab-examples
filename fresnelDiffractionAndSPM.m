close all;

FOV = 200e-6; 

Na = 2^10;
a = linspace(-FOV/2,FOV/2,Na);
da = a(2)-a(1);
Nb = 2^10;
b = linspace(-FOV/2,FOV/2,Nb);
db = b(2)-b(1);
[A,B]=meshgrid(a,b);
R = sqrt(A.^2 + B.^2);

lambda = 780e-9;

%% Gaussian Beam with SPM
R_fwhm = 1e-6;
I = exp(-R.^2/R_fwhm^2);
P = 20e-3; % beam power
I0 = P/(sum(I(:))*da*db);
I = I0*I;

L = 1e-3;
n2 = .73e-13; % [m^2/W]

maxPhase = 4*pi;
phase = maxPhase*I/max(I(:));
z = 1e-3;

E0 = (I.^(1/2)/(2*377)).*exp(1j*phase);

[x y E1] = fresnelProp(z,lambda,A,B,E0);
dx = x(2)-x(1);
dy = y(2)-y(1);
figure;
imagesc(a,b,angle(E0));
title('original field');
figure;
imagesc(x,y,abs(E1));
title(['field after z = ' num2str(z/1e-3) ' [mm]']);

%% Circular Aperature 
radius = 1e-6;
z = 2e-3;

E0 = double(R < radius);

[x y E1] = fresnelProp(z,lambda,A,B,E0);
figure;
imagesc(a,b,abs(E0));
figure;
imagesc(x,y,abs(E1));

%% Square Aperature 
width = 1e-6;
height = 1e-6;
z = 2e-3;

E0 = double(abs(A) < width).*double(abs(B) < height);

[x y E1] = fresnelProp(z,lambda,A,B,E0);
dx = x(2)-x(1);
dy = y(2)-y(1);
figure;
imagesc(a,b,abs(E0));
figure;
imagesc(x,y,abs(E1));