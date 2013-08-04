%% BBO at 1030 nm --> 515nm

no1030 = 1.65677;
ne1030 = 1.54170862;
no515  = 1.67564513;
ne515  = 1.55527768;

th = linspace(0,2*pi,1000 + 1);

x = cos(th);
y = sin(th);

plot(x*ne1030,y*no1030,'r-',x*no1030,y*no1030,'r:',...
    x*ne515,y*no515,'b-',x*no515,y*no515,'b:');
