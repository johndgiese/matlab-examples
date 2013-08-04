% Fresnel Diffraction Integrals (See Chapter 4 of Fourier Optics, Goodman)

%% Parameters
% Physical Parameters and Derived Values
lambda = 500e-9; %m
k = 2*pi/lambda;

% Spatial Parameters
w = .002; %m
res = 1000;
x = linspace(-w,w,res(1)); %m
% y = linspace(-w,w,res(2)); %m
% [X Y] = meshgrid(x,y);
% z = (1:400)*10^-3; %m
z = logspace(-4,-1,200);

%% Define the Complex Amplitude at z = 0
% Rectangular Pupil
f = double(abs(x) < w/8);
% f = .5*(1+cos(2*pi*x/.1));

%% Perform the Fresnel Convolution Integral (and generate movie)
U = zeros([res length(z)]);
for zPos = 1:length(z)
   h = exp(1i*k*z(zPos))*exp((1i*k)/(2*z(zPos))*(x.^2));
   U(:,zPos) = convn(f,h,'same');
end

close all;
imagesc(z,x,abs(U(ceil(res/8):(end-ceil(res/8)),:)));
colormap('gray');

%% Generate a Movie Based on the Intensity of U
figure;
plot(U(:,1));
set(gca,'nextplot','replacechildren');
for zPos = 1:length(z)
   temp = U(:,zPos);
   plot(abs(U(:,zPos)));
   F(zPos) = getframe;
end
[h, w, p] = size(F(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'position', [150 150 w h]);
axis off
% tell movie command to place frames at bottom left
movie(hf,F,4,30,[0 0 0 0]);