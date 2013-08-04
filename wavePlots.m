% Wave Visualization
% note that many of the distances are unrealistic, but are used to simplify
% visualization
close all;

ll = 500; % wavelength in nm
k0 = 2*pi/ll; % wavenumber
xmin = -2*ll;
xmax = 2*ll;
zmin = 0;
zmax = 10*ll;
x = linspace(xmin,xmax,500);
z = linspace(zmin,zmax,500);
[Z X] = meshgrid(z,x);

n = 1.4;
R1 = 2000; % lens radius in nm
R2 = -R1;
f = 1/((n-1)*(1/R1 - 1/R2));

% straight plane-wave after thin-lense
U = exp(1i*k0*X.^2./(2*f)).*exp(-1i*k0*Z);
imagesc([zmin zmax],[xmax xmin],real(U));
title('Plane Wave After a Thin Lense with \theta = 0');

% angled plane-wave after thin-lense
theta = 20/360*2*pi;
U2 = exp(-1i*k0*theta*X).*exp(1i*k0*X.^2./(2*f)).*exp(-1i*k0*Z);
figure;
imagesc([zmin zmax],[xmax xmin],real(U2));
title(['Plane Wave After a Thin Lense with \theta = ' num2str(theta)]);

% fresnel wave after thin lense
z1 = ll;
U0 = exp(-1j*k0*z1).*exp(-1i*k0*X.^2/z1);
U3 = U0*exp(1j*k0*X.^2/(2*f)).*exp(-1i*k0*Z);
figure;
imagesc([zmin zmax],[xmax xmin],real(U3));
title(['Plane Wave After a Thin Lense with \theta = ' num2str(theta)]);