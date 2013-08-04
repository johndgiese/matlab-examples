% This file demonstrates some interesting properties of phasors, and shows
% how useful they are as a conceptual device when dealing with speckle of
% coherent, and quasi-coherent light.

fpc = 60;
Ncycle = 4;
t = linspace(0,Ncycle*2*pi,Ncycle*fps);

%% biased incoherent
N = 4;
b = randn(N,1) + 1i*randn(N,1) + .5; % bias them a little for demo purposes
dw = .4;

wb = (randn(N,1)*dw^2 + 1);

%% biased coherent

N = 4;
a = randn(N,1) + 1i*randn(N,1) + .5; % bias them a little for demo purposes
dw = .2;

wa = ones(N,1);

%% generate movie

% Preallocate the struct array for the struct returned by getframe
F(length(t)) = struct('cdata',[],'colormap',[]);

% Record the movie
figure;

for k = 1:length(t)
    A = cumsum([0; a.*exp(1j*wa*t(k))]);
    B = cumsum([0; a.*exp(1j*wb*t(k))]);
    plot(real(A),imag(A),'r:',[0; real(A(end))],[0; imag(A(end))],'r',...
        real(B),imag(B),'k:',[0; real(B(end))],[0; imag(B(end))],'k');   
    
    if (k == 1)           
        axis square;
        lim = sum(abs(a));
        axis([-lim lim -lim lim]);
        set(gca,'NextPlot','replacechildren');
    end
    
    F(k) = getframe;
end

%% play movie
movie(F,1,5)