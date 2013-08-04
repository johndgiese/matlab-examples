close all;
ptSpacing = 0.02;
x = 0:ptSpacing:1;
y = 0:ptSpacing:1;

% a regular function
funcString = 'conj(Z).^2';
wzmap(x,y,funcString);

% a non-regualar function
funcString = 'Z.^2';
wzmap(x,y,funcString);

funcString = 'exp(Z)';
wzmap(x,y,funcString);

funcString = 'cos(Z/(2*pi))';
wzmap(x,y,funcString);

x2 = 0:.1:2;
y2 = 0:.05:pi;
funcString = 'cosh(Z)';
wzmap(x2,y2,funcString);

funcString = 'sinh(Z)';
wzmap(x2,y2,funcString);