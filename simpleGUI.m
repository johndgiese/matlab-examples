function simpleGUI()
% GAUSSGUI visualize properties of hermite-gaussian beams

close all;
lambda = 5;
x = linspace(0,2,30);
xc = linspace(0,2,500);
y = cos(2*pi*x/lambda);
yc = cos(2*pi*xc/lambda);
hf = figure('Units','normalized','Position',[0 0 1 1],'MenuBar','none','ToolBar','none','Units','normalized');
ha = axes('OuterPosition',[.02 .10 .9 .85]);    
hstem = stem(x,y,'k');
set(hstem,'YDataSource','y');
set(hstem,'XDataSource','x');
title('The Effect of Aliasing on a Sampled Sine-Wave','FontWeight','bold');
ylabel('');
xlabel('');
hold on;
hplot = plot(xc,yc,'r:');
set(hplot,'YDataSource','yc');
set(hplot,'XDataSource','xc');
hold off;
hLambda = uicontrol('Style','slider','String','lambda','Value',.5,...
    'Max',1,'Min',.01,'Callback',@lambdaCallback,'Units','normalized','Position',[.2 0.05 .6 .05]);

    function lambdaCallback(hObject,eventdata)
        lambda = get(hObject,'Value');
        y = cos(2*pi*x/lambda);
        yc = cos(2*pi*xc/lambda);
        refreshdata(hplot,'caller');
        refreshdata(hstem,'caller');
    end
end