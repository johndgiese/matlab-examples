x = linspace(-4,4,500);
y = polyval(hermitePoly(0),x).*exp(-x.^2/2);
plot(x,y);