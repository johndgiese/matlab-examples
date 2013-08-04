% Dirichlet Problem:
% d^2(u)/dx^2 + d^2(u)/dy^2 = 0
% 0 < x < a
% 0 < y < b
% zero on all boundaries except u(x,0) = 1
% The solution was solved analytically, and this was used to plot the
% result.

ccc;
a = 5;
b = 2;

A = @(n) 4./((2.*n-1)*pi)./sinh((2.*n-1)*pi*b/a);

resx = 30;
resy = 30;
x = linspace(0,a,resx);
y = linspace(0,b,resy);
[X Y] = meshgrid(x,y);
u = zeros(resx,resy);

order = 30;
for ii = 1:order
    u = u + A(ii)*sin((2*ii-1)*pi*X/a).*sinh((2*ii-1)*pi*(b-Y)/a);
end

surface(X,Y,u);