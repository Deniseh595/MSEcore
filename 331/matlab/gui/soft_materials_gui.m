function varargout = soft_materials_gui(varargin)
% SOFT_MATERIALS_GUI MATLAB code for soft_materials_gui.fig
%      SOFT_MATERIALS_GUI, by itself, creates a new SOFT_MATERIALS_GUI or raises the existing
%      singleton*.
%
%      H = SOFT_MATERIALS_GUI returns the handle to a new SOFT_MATERIALS_GUI or the handle to
%      the existing singleton*.
%
%      SOFT_MATERIALS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFT_MATERIALS_GUI.M with the given input arguments.
%
%      SOFT_MATERIALS_GUI('Property','Value',...) creates a new SOFT_MATERIALS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before soft_materials_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to soft_materials_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help soft_materials_gui

% Last Modified by GUIDE v2.5 24-Oct-2013 14:36:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @soft_materials_gui_OpeningFcn, ...
    'gui_OutputFcn',  @soft_materials_gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before soft_materials_gui is made visible.
function soft_materials_gui_OpeningFcn(hObject, eventdata, handles, varargin)
set(hObject,'CloseRequestFcn',@closeGUI)

fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');

handles.output = hObject;
handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes soft_materials_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = soft_materials_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------This Section is for Infinite Random Walk-----
%-----------------------------------------------------
function randomwalk_Callback(hObject, eventdata, handles)
%RandomWalk will take a certain number of random steps for however many iterations are specified
steps=str2double(get(handles.steps,'string'));

cla(handles.axes1);
reset(handles.axes1);
axeslimits = 15;
axis(handles.axes1, [-axeslimits axeslimits -axeslimits axeslimits]);
axis(handles.axes1, 'square');

r = 0.5;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

p = [0,0]; %defines the starting position

hold(handles.axes1, 'on');
    
%Creating the Start and Finish Circles
Xstart=X+p(1);
Ystart=Y+p(2);
start=fill(Xstart,Ystart, 'b');
finish = fill(Xstart, Ystart, 'b');

for total = 1:steps;
    delete(finish);
    p0 = [2*rand-1, 2*rand-1];
    %creates a random 2-member vector with an equal probability for any number from -1-1 to appear...
    
    pmag = norm(p0); %takes the magnitude of the vector
    punit = p0/pmag; %creates a unit vector from the randomized vector
    pnew = p + punit; %adds the unit vector to the original point
    
    plot(handles.axes1, [p(1) pnew(1)], [p(2) pnew(2)]); %connects the original point to the new point
    
    p = pnew; %set the new point as the point that the next movement will be based off of
    drawnow; %realtime graphing to show lines being drawn
    
    Xfinish = X+pnew(1);
    Yfinish = Y+pnew(2);
    finish = fill(Xfinish, Yfinish, 'g');

    xlimits = get(handles.axes1, 'xlim');
    ylimits = get(handles.axes1, 'ylim');
        
    if pnew(1) <= xlimits(1) || pnew(1) >= xlimits(2) || pnew(2) <= ylimits(1) || pnew(2) >= ylimits(2);
        
        axis(handles.axes1, 'auto');
    end
    pause(0.05); %Pause to allow the moving green circle to be seen
end

pause(0.5); %Pause for effect

%Plot a line from the start to the end
Xvector = linspace(0, p(1), 1000);
Yvector = linspace(0, p(2), 1000);
plot(Xvector, Yvector, 'r');

hold(handles.axes1, 'off');

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%------------------------------------------------------------------
% --- Detail Popup for the Infinite-Directional 2D Random Walk
function RW2Ddetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('2-D Infinite Random Walk');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

RW1Ddetail = figure('position', [100, 100, 400, 400], 'color', [0.4 1 .4], 'numbertitle', 'off', 'name', '2-D Random Walk with Infinite Movement Directions');
RW1Ddetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(RW1Ddetailtext, 'string', stringtext);
set(RW1Ddetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.4 1 .4], 'units', 'normalized');

%--------This Section is for the Limited 2-D Random Walk--------
%---------------------------------------------------------------
function randomwalk4d_Callback(hObject, eventdata, handles)
steps=str2double(get(handles.steps,'string'));

cla(handles.axes1);
reset(handles.axes1);
axeslimits = 15;
axis(handles.axes1, [-axeslimits axeslimits -axeslimits axeslimits]);
axis(handles.axes1, 'square');

r = 0.5;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

p = [0,0]; %defines the starting position

hold(handles.axes1, 'on');
    
%Creating the Start and Finish Circles
Xstart=X+p(1);
Ystart=Y+p(2);
start=fill(Xstart,Ystart, 'b');
finish = fill(Xstart, Ystart, 'b');

for total = 1:steps;
    delete(finish);
    A = rand;
    %generates a random value in between 0 and 1 for A
    
    if 0 <= A & .25 >= A;
        pnew = p+[1,0];
    elseif .125 < A & .5 >= A;
        pnew = p+[0,-1];
    elseif .25 < A & .75 >= A;
        pnew = p+[-1,0];
    elseif .375 < A & 1.00 >=A;     
        pnew = p+[0,1];
    end
    
    plot(handles.axes1, [p(1) pnew(1)], [p(2) pnew(2)]); %connects the original point to the new point
    
    p = pnew; %set the new point as the point that the next movement will be based off of
    drawnow; %realtime graphing to show lines being drawn
    
    Xfinish = X+pnew(1);
    Yfinish = Y+pnew(2);
    finish = fill(Xfinish, Yfinish, 'g');

    xlimits = get(handles.axes1, 'xlim');
    ylimits = get(handles.axes1, 'ylim');
        
    if pnew(1) <= xlimits(1) || pnew(1) >= xlimits(2) || pnew(2) <= ylimits(1) || pnew(2) >= ylimits(2);
        
        axis(handles.axes1, 'auto');
    end
    pause(0.05); %Pause to allow the moving green circle to be seen
end

pause(0.5); %Pause for effect

%Plot a line from the start to the end
Xvector = linspace(0, p(1), 1000);
Yvector = linspace(0, p(2), 1000);
plot(Xvector, Yvector, 'r');

hold(handles.axes1, 'off');

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%--------------------------------------------------------------------
% --- Detail Popup for the 4-Directional 2D Random Walk
function RW2D4detail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('2-D Limited Random Walk');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

RW2D4detail = figure('position', [100, 100, 400, 400], 'color', [0.4 1 .4], 'numbertitle', 'off', 'name', '2-D Random Walk with Four Movement Directions');
RW2D4detailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(RW2D4detailtext, 'string', stringtext);
set(RW2D4detailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.4 1 .4], 'units', 'normalized');

%--------This Section is for the 1-D Random Walk----------------
%---------------------------------------------------------------
function randomwalk1d_Callback(hObject, eventdata, handles)

cla(handles.axes1);
reset(handles.axes1);
set(handles.axes1,'nextplot','replacechildren')

steps = str2double(get(handles.steps1d, 'string'));
maxx=2*steps^0.5;
set(handles.axes1,'xlimmode','manual')
xlim(handles.axes1,[-maxx maxx]);%Set the Axes of the Graph
ylim(handles.axes1,[-6 Inf]);
%Reset the Graph

presence = 0;
handles.onedwalk.presence = presence;

if isfield(handles.onedwalk, 'positive')
    struct2var(handles.onedwalk)
   else
       positive = zeros(1);
       negative = zeros(1);
       cero = zeros(1);
       walkcount = 0;
end

%Create initial Vectors to keep track of Positive and Negative Numbers

if get(handles.slowspeed, 'value')
    pausetime = 0.05;
elseif get(handles.fastspeed, 'value')
    pausetime = 0;
else
    pausetime = 0;
end
%Pre-allocating the time for the pause to determine speed

while ~get(handles.pausebutton, 'value');
    
    walker=text(0,-3,'O','horizontalalignment','center','fontsize',14);
    s = zeros(1);
    drawnow
    for z = 1:steps;
        
        gen = rand;
        if 0 <= gen && gen < 1/6;
            s0 = -1;
        elseif 1/6 <= gen && gen < 5/6
            s0 = 0;
        elseif 5/6 <= gen && gen <=1;
            s0 = 1;
        end
        
        snew = s+s0;
        s = snew;
        set(walker,'position',[s,-3])
        pause(pausetime);
    end
    
    if s == 0;
        cero = cero +1;
    elseif s < 0;
        if abs(s) > length(negative);
            negative(abs(s)) = 0;
        end
        negative(abs(s)) = negative(abs(s)) + 1;
        
    elseif s> 0;
        if abs(s) > length(positive);
            positive(s) = 0;
        end
        positive(s) = positive(s) + 1;
    end
    
    y = [negative(end:-1:1) cero positive];
    x = [-length(negative):length(positive)];
    
    stem(x,y, '--pr');
    walkcount = walkcount + 1;
    set(handles.reps1d, 'string', walkcount);
    
end

handles.onedwalk.cero=cero;
handles.onedwalk.negative=negative;
handles.onedwalk.positive=positive;
handles.onedwalk.walkcount=walkcount;
guidata(hObject,handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in pausebutton.
function pausebutton_Callback(hObject, eventdata, handles)

% --- Executes on button press in clearbutton.
function clearbutton_Callback(hObject, eventdata, handles)
handles.onedwalk = rmfield(handles.onedwalk, {'cero', 'negative', 'positive', 'walkcount'});
guidata(hObject,handles);

%---------------------------------------------------------------
%This segment is for Graphing the Gaussian Curve
function gaussian_Callback(hObject, eventdata, handles)

hold(handles.axes1, 'on');

N = str2double(get(handles.steps1d, 'string'))/3;
M = str2double(get(handles.reps1d, 'string'));
ix = [-20:0.2:20];

NI = M*sqrt(1/(2*pi*N))*exp(-ix.^2/(2*N));

plot(handles.axes1, ix, NI);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%----------------------------------------------------------------
% --- Detail Popup for the 1D Random Walk
function RW1Ddetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('1-D Random Walk');

stringtext = stringfinder(stringid); %Calling External Function "stringfinder"
RW1Ddetail = figure('position', [100, 100, 400, 400], 'color', [0.4 1 .4], 'numbertitle', 'off', 'name', 'One-Dimensional Random Walk');
RW1Ddetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(RW1Ddetailtext, 'string', stringtext);
set(RW1Ddetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.4 1 .4], 'units', 'normalized');

%----------------------------------------------
%This Section is for extraneous matters

function closeGUI(src,~)
%src is the handle of the object generating the callback (the source of the event)
%evnt is the The event data structure (can be empty for some callbacks)
selection = questdlg('Do you want to save the file?',...
    'Close Request Function',...
    'Yes','No','Cancel','Yes');
switch selection,
    case 'Yes',
        hgsave(src,'soft_materials_gui.fig')
        delete(gcf)
    case 'No'
        delete(gcf)
    case 'Cancel'
        return
end

% --- Executes on button press in resetgraphs.
function resetgraphs_Callback(hObject, eventdata, handles)

cla(handles.axes1);
reset(handles.axes1);

function struct2var(s)
%STRUCT2VAR Convert structure array to workspace variables.
%   STRUCT2VAR(S) converts the M-by-N structure S (with P fields)
%   into P variables defined by fieldnames with dimensions M-by-N.  P
%   variables are placed in the calling workspace.
%
%   Example:
%     clear s, s.category = 'tree'; s.height = 37.4; s.name = 'birch';
%     c = struct2cell(s); f = fieldnames(s);
%
%   See also STRUCT2CELL, FIELDNAMES.

% Copyright 2010 The MathWorks, Inc.
if nargin < 1
    error('struct2var:invalidInput','No input structure found')
elseif nargin > 1
    error('struct2var:invalidInput','Too many inputs')
elseif ~isstruct(s)
    error('struct2var:invalidInput','Input must be a structure data type')
end

[r,c] = size(s);
names = fieldnames(s);

for i=1:length(names)
    assignin('caller',names{i},s.(names{i}))
end
    
