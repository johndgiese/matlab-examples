function varargout = simpleRayTraceGUI(varargin)
% RAYTRACESIMPLEGUI Idealized ray tracer.

%  Initialization tasks
scrsz = get(0,'ScreenSize');
fh = figure('MenuBar','none','Name','Simple Ray Tracer','Toolbar','none',...
    'Position',[0 0 scrsz(3) scrsz(4)],'Visible','on');

%%  CONSTRUCT THE COMPONENTS
pad = 10; % distance from figure border to elements
topMarg = 30; % height of menu and windows bar

% OPTICAL COMPONENT TABLE
cnames = {'Type','P1'};
cformat = {{'--','space','lens'},'numeric'};
maxNC = 20; % maxium number of components
cdata = cell(maxNC,length(cnames)); cdata(:,1) = {'--'}; cdata(:,2) = {0};
ceditable = [true true];
cwidth = {60,30};
th = uitable(fh,'Data',cdata,'ColumnName',cnames,'ColumnFormat',cformat,...
    'ColumnEditable',ceditable,'ColumnWidth',cwidth);
textent = get(th,'Extent');
cposition = [pad,scrsz(4)-textent(4)-pad-topMarg,textent(3:4)];
set(th,'Position',cposition);

% RAY TRACE AXES
aposition = [0.1787 0.1145 0.7792 0.8376];
ah = axes('Parent',fh,'Position',aposition);

% CONTROL ELEMENTS
holdButton = uicontrol('Style','checkbox','String','Hold Plots?',...
    'Position',[15 169 83 20]);
plotButton = uicontrol('Style','pushbutton','String','Update Plot',...
    'Position',[15 117 89 42],'CallBack',{@plotButtonCallback,ah,th,...
    holdButton});

%%  INITIALIZATION TASKS

% default lens setups
cdata{1,1} = 'space'; cdata{1,2} = 3;
cdata{2,1} = 'lens'; cdata{2,2} = 3;
cdata{3,1} = 'space'; cdata{3,2} = 6;
set(th,'Data',cdata);

%%  CALLBACKS

    function plotButtonCallback(hobject, eventdata, ah, th, holdButton)
        sysData = get(th,'Data'); % get the lens positions from the table
        compTypes = sysData(:,1);
        numLens = 0;
        numSteps = 0;
        for k = 1:length(compTypes)
            if ~strcmp(compTypes{k},'--')
                numSteps = numSteps + 1;
                if strcmp(compTypes{k},'lens')
                    numLens = numLens + 1;
                end
            else                
                break; % the components must be at the "top" of the table
            end
        end
        numRays = 10;
        rays = [linspace(-1,1,numRays); zeros(1,numRays)];
        plotDataY = zeros(numSteps+1,numRays);        
        plotDataX = zeros(numSteps+1,1);
        d = 0; % distance from previous component
        for k = 1:(numSteps+1)       
            plotDataX(k) = d;
            plotDataY(k,:) = rays(1,:);
            if strcmp(sysData(k,1),'lens')
                f = sysData{k,2};                
                stepMatrix = [1 0; -1/f 1]; % ray-matrix for a lense
                d = 0;
            elseif strcmp(sysData(k,1),'space')
                d = sysData{k,2};
                stepMatrix = [1 d; 0 1]; % ray-matrix for space propogation
            elseif strcmp(sysData(k,1),'--')
                continue;
            end            
            rays = stepMatrix*rays;
        end
        plotDataX = cumsum(plotDataX);
        % ^^ convert the inter-component distances to absolute distances
       
        cVECT = {'r:','g:','b:'};
        persistent numHolds;
        if get(holdButton,'Value') == true
            hold on;
            plot(ah,plotDataX,plotDataY,cVECT{mod(numHolds,3)+1});
            hold off;
            numHolds = numHolds + 1;
        else
            plot(ah,plotDataX,plotDataY,'k');
            numHolds = 1;
        end
        return;
    end

%  Utility functions for MYGUI

end


