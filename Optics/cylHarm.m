% this isn't finished, but it was an attempt to model cylindrical harmonics
% in an optical fiber

% SEE Fundamentals of Photonics 2e, Section 9.2

r = linspace(0,10,100);
u = zeros(size(r));
u0 = 1;
du0 = 0;
k_T = 1;

K = 2000;
a = zeros(1,K);
a(1) = 1;
a(2) = 0;

for k = 3:K
    a(k) = -k_T^2/(k+1)^2*a(k-2);
end

for k = 1:K
    u = u + a(k)*r.^(k-1);
end

plot(r,u);