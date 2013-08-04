
t0 = 0;
tf = 10;

n = 10;
a = linspace(.1,3,n);
colors = linspace(0,1,n);

figure; hold on;
for i = 1:n
    y0 = a(i);
    odefun = @(t,y) y*(1-y);
    [T Y] = ode45(odefun,[t0 tf],y0);
    h = plot(T,Y);
    set(h,'Color',[1-colors(i), 0, colors(i)]);
end
hold off;
legend(num2str(a',' %4.2f'));
title(func2str(odefun));
xlabel('time');