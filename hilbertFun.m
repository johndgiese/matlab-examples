t = 0:0.1:20-0.1;
x1 = 3*cos(2*pi*t/20); 
x2 = sin(2*pi*t/2);
x = x1 + x2;
h1 = hilbert(x1);
h2 = hilbert(x2);
h = hilbert(x);

p1 = real(h1)+real(h2);
p2 = imag(h1)+imag(h2);
plim = max(abs(h))+1;

scrsz = get(0,'ScreenSize');
figure('Position',[100 100 scrsz(3)-200 scrsz(4)-200])
subplot(121);
plot(t,abs(h),'r',t,x,'g');
legend('Envelope','Original');
hold on;
sweepLine = line([t(1) t(1)],[-plim plim]);
hold off;
title('Envelope of Extraction Using the Hilbert Tranform');
subplot(122);
axis([-plim plim -plim plim]);
title('Phasor Diagram');
axis square;
for i = 1:length(t)
    subplot(122);
    plot([0 real(h2(i))],[0 imag(h2(i))],'Color','r');
    hold on;
    plot([real(h2(i)) real(h1(i))+real(h2(i))],...
        [imag(h2(i)) imag(h1(i))+imag(h2(i))],'Color','g');
    plot(p1(1:i),p2(1:i),'k:');
    hold off;
    axis([-plim plim -plim plim]);
    axis square;
    title('Phasor Diagram');
    set(sweepLine,'XData',[t(i) t(i)]);
    F(i) = getframe; %#ok<SAGROW>
end
