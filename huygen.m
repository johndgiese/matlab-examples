% only barely works...

lambda = 520e-9;

M = 48;

% circle with radius r
% r = .1;
% x1 = linspace(-r,r,M);
% y1 = linspace(-r,r,M);
% [X1 Y1] = meshgrid(x1,y1);
% R1 = sqrt(X1.^2+Y1.^2);
% E1 = zeros(size(X1));
% E1(R1 < r) = 1;

% % rectangle
N0 = 64;
h = 0.003949683531626;
w = 0.003949683531626;
x1 = linspace(-h,h,N0);
y1 = linspace(-w,w,N0);
E1 = ones(length(x1),length(y1));

ds = (x1(2)-x1(1))*(y1(2)-y1(1));

% two single points
% M = 1;
% E1 = ones(2,1);
% x1 = [-3 3];
% y1 = 0;
% ds = .1;

% prop distance
z = 3;

% setup propagated field
N = 128;
d = 2*w;
x2 = linspace(-d,d,N);
y2 = linspace(-d,d,N);
E2 = zeros(length(x2),length(y2));

for n = 1:length(x2)
    for nn = 1:length(y2)
        for m = 1:length(x1)
            for mm = 1:length(y1)
                if (E1(m,mm) ~= 0)
                    r2 = (x2(n)-x1(m))^2+(y2(nn)-y1(mm))^2+z^2; % r-squared
                    E2(n,nn)=E2(n,nn)+E1(m,mm)*exp(-2j*sqrt(r2)*pi/lambda)*z/r2;
                end
            end
        end        
    end
    display(['row ' num2str(n) ' of ' num2str(length(x2))]);
end
E2 = E2/(1j*lambda)*ds;

%%
I1 = abs(E1).^1;
I2 = abs(E2).^2;

figure;
subplot(211);
imagesc(I1);
subplot(212);
imagesc(x2,y2,I2);