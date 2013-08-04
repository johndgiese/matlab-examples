% This file simulates a the effect of a series of lenses on a gaussian
% beam.  The original gaussian beam is defined to start at 0, with a
% rayleigh range defined by z0. The positions (d) and focal lengths (f) of
% an arbitrary number of lenses can be simulated.  The beam-width is then
% plotted for the full length of the system.

if ~exist('hf','var')
    ha = axes('OuterPosition',[.02 .10 .9 .85]);
end

% define the system parameters
lambda = 533e-9;
z0_init = 2e-3;
W0_init = sqrt(lambda*z0_init/pi);
d = [d_init 5 5 5 5 5 5 5 5 5]*1e-3; % spacing between lenses
f = [2 2 2 2 2 2 2 2 2 2 2]*1e-3; % focal length of the lenses

% initialize calculated values
z = zeros(1,length(d)+1);
z0 = zeros(1,length(d)+1);
W0 = zeros(1,length(d)+1);
z(1) = 0; % this defines the coordinate system
z0(1) = z0_init;
W0(1) = W0_init;

% calculate z, z0, and W0 for each portion of the system
for i = 1:length(d)   
    M_r = abs(f(i)/(d(i) - z(i) - f(i)));
    r = z0(i)/(d(i) - z(i) - f(i));
    if isnan(M_r)
        M_r = abs(f(i)/(d(i) - z(i) - f(i) + eps));
        r = z0(i)/(d(i) - z(i) - f(i)+eps);
    end
   
    M = M_r/sqrt(1+r^2);
    
    z(i+1) = f(i) + M^2*(d(i) - z(i) - f(i));
    W0(i+1) = M*W0(i);
    z0(i+1) = M^2*z0(i);    
end

dz = 1e-5;
zp = -d(1):dz:d(1);
W = W0(1)*sqrt(1+(zp/z0(1)).^2);
dsum = cumsum(d);
% calculate the waist-radius along the full length of the system
for i = 2:length(d)
    zt = (dsum(i-1)+dz):dz:dsum(i); % temporary z-values for plotting
    zp = [zp zt]; % all z-values for plotting
    Wt = W0(i)*sqrt(1+((zt-z(i)-dsum(i-1))/z0(i)).^2);
    W = [W Wt];
end
zt = (dsum(end)+dz):dz:(dsum(end)+2*z(end));
Wt = W0(end)*sqrt(1+((zt-z(end)-dsum(end))/z0(end)).^2);
zp = [zp zt]; 
W = [W Wt];

Wmax = max(W(:));
plot(zp,W);
hold on; scatter(dsum,zeros(size(dsum)),'r')
for i = 1:length(d)
    plot([dsum(i) dsum(i)],[Wmax -Wmax],'k-');
end
scatter([0 dsum]+z,zeros(size(z)),'g');
plot(zp,-W);
hold off;