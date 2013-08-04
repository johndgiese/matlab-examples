%% Lithium Niobate (LiNbO_3)
% This equation is from Jundt, 15 October 1997

f = @(T) (T-24.5)/(T+570.82);

a1 = 5.35583;
a2 = 0.100473;
a3 = 0.20692;
a4 = 100;
a5 = 11.34927;
a6 = 1.5334e-2;
b1 = 4.629e-7;
b2 = 3.862e-8;
b3 = -0.89e-8;
b4 = 2.657e-5;

% this is accurate between T = [20,250] deg C, and lambda = [.4,5] um
ne = @(l,T) sqrt(a1 + b1*f(T) + (a2+b2*f(T))./((l).^2-(a3+b3*f(T)).^2) + ...
    (a4+b4*f(T))./((l).^2-a5^2) - a6*(l).^2);
% note: temperature dependence is extremely small

% example figure
lambda = linspace(.400,5.000,1000);
figure; plot(lambda,ne(lambda,20));
xlabel('wavelength [um]');
ylabel('extraordinary index-of-refraction [-]');
title('Index of refraction of Lithium Niobate (Jundt 1997)');
legend('extraordinary');

%% Lithium Niobate (LiNbO_3)
% This is from fundamentals of photonics 2e

% this is "valid" for lambda = [.4,3.1] um at room temperature
ne = @(l) sqrt(2.3247 + 2.2565*l.^2./(l.^2-0.210^2) + 14.503*l.^2./(l.^2-25.915^2));
no = @(l) sqrt(2.3920 + 2.5112*l.^2./(l.^2-0.217.^2) + 7.1333*l.^2/(l.^2-16.502.^2));

% lambda = linspace(.400,3.100,1000);
lambda = linspace(.500,0.600,1000);
figure; plot(lambda,ne(lambda),lambda,no(lambda));
xlabel('wavelength [um]');
ylabel('index-of-refraction [-]');
title('Index of refraction of Lithium Niobate (Fund. of Photonics)');
legend('extraordinary','ordinary');

%% Fused Silica
% This is from fundamentals of photonics 2e

% this is "valid" for lambda = [.21,3.71] um at room temperature
n = @(l) sqrt(1 + 0.6962*l.^2./(l.^2-0.06840^2) + 0.4079*l.^2./(l.^2-0.1162^2) + ...
    0.8975*l.^2./(l.^2-9.8962^2));
lambda = linspace(.210,3.710,1000);
figure; plot(lambda,n(lambda));
xlabel('wavelength [um]');
ylabel('index-of-refraction [-]');
title('Index of refraction of Fused Silica (Fund. of Photonics)');

%% Quartz 
% this is from a Melles Griot Appendix (it is a Laurent Series, not
% selleimeir) also note that the temperature is not specified, so I am
% assuming room temperature.

A0 = 2.3849; A1 = -1.259e-2; A2 = 1.079e-2; A3 = 1.6518e-4; 
A4 = -1.9471e-6; A5 = 9.36476e-8;
ne = @(l) sqrt(A0 + A1*l.^2 + A2./l.^2 + A3./l.^4 + A4./l.^6 + A5./l.^8);

A0 = 2.35728; A1 = -1.17e-2; A2 = 1.054e-2; A3 = 1.34143e-4; 
A4 = -4.45368e-7; A5 = 5.92362e-8;
no = @(l) sqrt(A0 + A1*l.^2 + A2./l.^2 + A3./l.^4 + A4./l.^6 + A5./l.^8);

lambda = linspace(.400,3.100,1000);
lambda = linspace(.510,0.520,1000);
figure; plot(lambda,ne(lambda),lambda,no(lambda));
xlabel('wavelength [um]');
ylabel('index-of-refraction [-]');
title('Index of refraction of Quartz');
legend('extraordinary','ordinary');