%% EXPLORATION OF THE TAYLOR EXPANSION OF y(x) = sqrt(1+x)

x = linspace(-1,1,601)';
% The actual function.
y = sqrt(1+x); 
% The taylor expansion coefficients.
coef = @(n) (-1).^n.*factorial(2*n)./((1-2.*n).*factorial(n).^2.*4.^n);
% the highest order approximation to be calculated
order = 15; 

Y = zeros(length(x),order+1);
Y(:,1) = coef(0);
for i = 2:order+1
    Y(:,i) = Y(:,i-1) + coef(i-1)*x.^(i-1);
end

figure;
hold on;
% loop creates an alternating green/red pattern for each plot; the
% saturation also decreases to black as the order increases
for i = 1:order+1
    if mod(i,2)
        plot(x,Y(:,i),'Color',[(1 - (i-1)/(order+2)) 0 0]);
    else
        plot(x,Y(:,i),'Color',[0 (1 - (i-1)/(order+2)) 0]);
    end
end
plot(x,y,'k:');
hold off;
title('The Taylor Expansion of $\displaystyle y = \sqrt{1+x}$',...
    'interpreter','latex');
