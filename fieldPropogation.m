% Simulation of field propogation in a planar-mirror wave guide (see
% Fundamentals of Photonics 2ed, Section 8.1
%
% This simulation models light propogation entering a planar-mirror wave
% guide.  Assuming that there are no currents in the mirrors, Maxwells
% equations require the tangential electric-field to be 0 along the edges.
% This places a severe restriction on the waves that can propogate between
% the mirror.  Specifically there are pairs of TEM waves that combine and
% cancel out on the boundaries for all z (z is the direction of
% propogation, and y is perpendiular to the mirrors).  This simulation
% takes a given input light intensity, specified by the user in y0, and
% determines how much it excites each normal mode.  These weightings are
% then used to simulate the propogation of light within the planar
% waveguide.  Notice that as you reduce d/lambda, the number of modes
% available reduces.
% 
% There are a number of test input wave fronts (y0) commented out that
% you can try.  Also uncomment the movie section to construct a movie.

clear all; close all; clc;

% PHYSICAL PARAMETERS
d = 10e-6; %wave-guide width (m)
lambda_0 = 500e-9; % excitation wavelength in air (n \approx 1) (m)
n = 1;

% DERIVED VALUES
lambda = lambda_0/n;
M = floor(2*d/lambda); %number of modes
k_y = (1:M)*pi/d; % component of wave-vector in y direction
beta = sqrt((2*pi/lambda)^2 - ((1:M)*pi/d).^2); % same as k_z

% DEFINE SPATIAL COORDINATE SYSTME
ny = 500; % resolution in y-direction
y = linspace(d/2,-d/2,ny)';
dy = abs(y(1)-y(2));
nz = 4000; %resolution in z-direction
z = linspace(0,100*lambda,nz); %change the second parameter to increase
%how for along the simulation goes in the z-direction (or equivalently in
%time)
[Z,Y] = meshgrid(z,y);

% CONSTRUCTE INITAL WAVE FRONT
% % y0 = rand(ny,1)+10*exp(-(y/d).^2); % randomized gaussian
% y0 = zeros(ny,1); y0(floor(ny/2)-2:(floor(ny/2)+2)) = 10; %delta function in middle;
y0 = zeros(ny,1); y0(floor(ny/2)-100:(floor(ny/2)-5)) = 10; %delta function in middle;
% m = 1; y0 = sqrt(2/d)*cos(k_y(m)*y); % excite an odd mode (m must be odd!)
% m = 11; y0 = y0 + sqrt(2/d)*cos(k_y(m)*y); % excite an odd mode (m must be odd!)

% DETERMINE THE MODE POWER DISTRIBUTION (essentially a lowpassed FT)
A = zeros(M,1); % mode coefficients
for m = 1:M
    if mod(m,2) % isodd?
        A(m,:) = sqrt(2/d)*cos(k_y(m)*y')*y0;
    else
        A(m,:) = sqrt(2/d)*sin(k_y(m)*y')*y0;
    end     
end

% CONSTRUCT EX FROM COMIBINATION OF MODES
Ex = zeros(ny,nz); % electricfield values
for m = 1:M
    if mod(m,2) % isodd?
        yfactor = 2*cos(k_y(m)*y);
    else
        yfactor = 2i*sin(k_y(m)*y);
    end 
    zfactor = exp(-1i*beta(m)*z);
    Ex = Ex + A(m)*yfactor*zfactor; %this works because eqn 8.1-5 is seperable
end

%% GENERATE A MOVIE (Ex(y) as z changes)
plot(y,abs(Ex(:,1)));
axis([y(ny) y(1) 0 1.1*max(abs(Ex(:)))]);
h = gca;
set(gca,'nextplot','replacechildren');
mfc = 1; %movie frame counter
for ii = 1:nz % use middle term to compress number of frames
    plot(y,abs(Ex(:,ii)));
    F(mfc) = getframe; mfc = mfc + 1;
end

%% CREATE AN IMAGE OF Ex
figure;imagesc(z,y,abs(Ex));

%% CALCULATE HOW MUCH ENERGY WAS LOST FROM y0 (i.e. how good is the
% coupling?) note the values are only proportional
display(['Original energy in y0 = ' num2str(sum(abs(y0).^2))]);
display(['Energy in all modes = ' num2str(sum(abs(A).^2)*dy)]);
mDisp = 10;
if(M <= mDisp), mDisp = M; end
display(['Energy in the first ' num2str(mDisp) ' modes are: ']);
num2str(dy*abs(A(1:mDisp)).^2, '%10.5f\n')

%% PLOT THE MODES
close all;
figure;hold on;
mDisp = 5;
if(M <= mDisp), mDisp = M; end
for m = 1:mDisp
    if mod(m,2) % isodd?
        yfactor = 2*cos(k_y(m)*y);
        plot(y,real(yfactor));   
    else
        yfactor = 2i*sin(k_y(m)*y);
        plot(y,imag(yfactor));   
    end
    
end

