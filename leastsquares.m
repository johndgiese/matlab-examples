% Line Fitting with Least Squares Approximation

x = linspace(0,10,7)';
y = x + rand(size(x));

A = [ones(size(x)) x x.^2 x.^3 x.^4 x.^5 x.^6 x.^7];

xh = (A'*A)\(A'*y); % this is key
display(xh);

close all;
scatter(x,y);
hold on;
plot(x,A*xh,'r');
bar(x,y - A*xh);
hold off;