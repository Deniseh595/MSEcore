function varargout = chain_dimensions_gui(varargin)
% CHAIN_DIMENSIONS_GUI MATLAB code for chain_dimensions_gui.fig
%      CHAIN_DIMENSIONS_GUI, by itself, creates a new CHAIN_DIMENSIONS_GUI or raises the existing
%      singleton*.
%
%      H = CHAIN_DIMENSIONS_GUI returns the handle to a new CHAIN_DIMENSIONS_GUI or the handle to
%      the existing singleton*.
%
%      CHAIN_DIMENSIONS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHAIN_DIMENSIONS_GUI.M with the given input arguments.
%
%      CHAIN_DIMENSIONS_GUI('Property','Value',...) creates a new CHAIN_DIMENSIONS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chain_dimensions_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chain_dimensions_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chain_dimensions_gui

% Last Modified by GUIDE v2.5 28-Aug-2013 20:30:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chain_dimensions_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @chain_dimensions_gui_OutputFcn, ...
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


% --- Executes just before chain_dimensions_gui is made visible.
function chain_dimensions_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chain_dimensions_gui (see VARARGIN)

% Choose default command line output for chain_dimensions_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chain_dimensions_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chain_dimensions_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%----This Section is for the Freely Jointed Chain Model Animation--
%-------------------------------------------------------------------
function FJCstart_Callback(hObject, eventdata, handles)

set(handles.FJCanimate, 'visible', 'on');
set(handles.FRCanimate, 'visible', 'off');
set(handles.BARanimate, 'visible', 'off');
set(handles.BAEanimate, 'visible', 'off');
set(handles.text1, 'visible', 'off'); set(handles.text2, 'visible', 'off');
set(handles.edit1, 'visible', 'off'); set(handles.edit2, 'visible', 'off');

cla(handles.axes1)
reset(handles.axes1)
cla(handles.axes2)
reset(handles.axes2)

axis(handles.axes1, [0 20 0 20]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');

%Creating the Balls and Stick Model
a = 1; b = 1; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

x1center = 5; y1center = 10; %X and Y Centers
x2center = 10; y2center = 10;
x3center = 15; y3center = 10;

x1 = [5 10];
x2 = [10 15];
y = [10 10];

line1 = plot(handles.axes1, x1, y, 'k');
line2 = plot(handles.axes1, x2, y, 'k');

ball1 = patch(x1center+horizaxis,y1center+vertaxis, 'r', 'parent', handles.axes1);
ball2 = patch(x2center+horizaxis,y2center+vertaxis, 'r', 'parent', handles.axes1);
ball3 = patch(x3center+horizaxis,y3center+vertaxis, 'r', 'parent', handles.axes1);

%Assigning Handles
handles.FJC.ball3 = ball3;
handles.FJC.ball2 = ball2;
handles.FJC.x3center = x3center; handles.FJC.y3center = y3center;
handles.FJC.x2center = x2center; handles.FJC.y2center = y2center;
handles.FJC.horizaxis = horizaxis; handles.FJC.vertaxis = vertaxis;
handles.FJC.line2 = line2;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in FJCanimate.
function FJCanimate_Callback(hObject, eventdata, handles)

struct2var(handles.FJC);

%Creating the Orbital Path
r = 5;
N = 200;
theta=linspace(0,-2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
xcenter = X+10;
ycenter = Y+10;

while get(handles.FJCanimate, 'value');
    
    for k = 1:length(xcenter);
        
        delete(line2);
        delete(ball3);
        delete(ball2);
        
        line2 = plot(handles.axes1, [10 xcenter(k)], [10 ycenter(k)], 'k');
        ball2 = patch(x2center+horizaxis,y2center+vertaxis, 'r', 'parent', handles.axes1);
        ball3 = patch(xcenter(k)+horizaxis, ycenter(k)+vertaxis, 'r', 'parent', handles.axes1);
        
        axis(handles.axes1, [0 20 0 20]);
        
        pause(0.01);
    end
end

handles.FJC.ball3 = ball3;
handles.FJC.ball2 = ball2;
handles.FJC.x3center = x3center; handles.FJC.y3center = y3center;
handles.FJC.x2center = x2center; handles.FJC.y2center = y2center;
handles.FJC.horizaxis = horizaxis; handles.FJC.vertaxis = vertaxis;
handles.FJC.line2 = line2;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%----This Section is for the Freely Rotating Chain Model Animation--
%-------------------------------------------------------------------
function FRCstart_Callback(hObject, eventdata, handles)

set(handles.FJCanimate, 'visible', 'off');
set(handles.FRCanimate, 'visible', 'on');
set(handles.BARanimate, 'visible', 'off');
set(handles.BAEanimate, 'visible', 'off');
set(handles.text1, 'visible', 'off'); set(handles.text2, 'visible', 'off');
set(handles.edit1, 'visible', 'off'); set(handles.edit2, 'visible', 'off');

cla(handles.axes1)
reset(handles.axes1)
cla(handles.axes2)
reset(handles.axes2)

axis(handles.axes1, [0 20 0 20]);
axis(handles.axes1, 'square');
axis(handles.axes2, [0 20 0 20]);
axis(handles.axes2, 'square');
hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

%Creating the Big Circle Diagrams
u = 5; v = 5;
r = linspace(0, 2*pi, 1000);
horizaxis1 = u*cos(r);
vertaxis1 = v*sin(r);

bigxcenter = 10; bigycenter = 10;
bigcircle = patch(bigxcenter+horizaxis1, bigycenter+vertaxis1,[0 0.5 0.5], 'parent', handles.axes2);

%Creating the Triangle and Oval Diagrams
trianglex = [5 11 11];
triangley = [10 15 5];

triangle = fill(trianglex, triangley, 'c', 'parent', handles.axes1);

n = 1; m = 5;
horizaxis2 = n*cos(r);
vertaxis2 = m*sin(r);

centerline = plot(handles.axes1, [5 11], [10 10], '--k');

ovalxcenter = 11; ovalycenter = 10;
oval = patch(ovalxcenter+horizaxis2, ovalycenter+vertaxis2,[0 0.5 0.5], 'parent', handles.axes1);

%Creating the Balls and Stick Model
a = .8; b = .8; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

%Creating the Balls on the Right Graph
x1center = 10; y1center = 5; %X and Y Centers
x2center = 10; y2center = 10;
x3center = 10; y3center = 15;

x = [10 10];
y1 = [5 10];
y2 = [10 15];

line1 = plot(handles.axes2, x, y1, 'k');
line2 = plot(handles.axes2, x, y2, 'k');

ball1 = patch(x1center+horizaxis,y1center+vertaxis, 'r', 'parent', handles.axes2);
ball2 = patch(x2center+horizaxis,y2center+vertaxis, 'r', 'parent', handles.axes2);
ball3 = patch(x3center+horizaxis,y3center+vertaxis, 'r', 'parent', handles.axes2);

%Creating the Balls on the Left Graph
x4center = 3.5; y4center = 5;
x5center = 5; y5center = 10;
x6center = 11; y6center = 10;
x7center = 11; y7center = 15;

x1 = [3.5 5];
x2 = [11 11];
y1 = [5 10];
y2 = [15 10];

line3 = plot(handles.axes1, x1, y1, 'k');
line4 = plot(handles.axes1, x2, y2, 'k');

ball4 = patch(x4center+horizaxis,y4center+vertaxis, 'r', 'parent', handles.axes1);
ball5 = patch(x5center+horizaxis,y5center+vertaxis, 'r', 'parent', handles.axes1);
ball6 = patch(x6center+horizaxis,y6center+vertaxis, 'r', 'parent', handles.axes1);
ball7 = patch(x7center+horizaxis,y7center+vertaxis, 'r', 'parent', handles.axes1);


%Assigning Handles
handles.FRC.ball3 = ball3; handles.FRC.ball2 = ball2;
handles.FRC.ball7 = ball7; handles.FRC.ball6 = ball6;
handles.FRC.x3center = x3center; handles.FRC.y3center = y3center;
handles.FRC.x2center = x2center; handles.FRC.y2center = y2center;
handles.FRC.x7center = x7center; handles.FRC.y7center = y7center;
handles.FRC.x6center = x6center; handles.FRC.y6center = y6center;
handles.FRC.horizaxis = horizaxis; handles.FRC.vertaxis = vertaxis;
handles.FRC.line2 = line2; handles.FRC.line4 = line4;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in FRCanimate.
function FRCanimate_Callback(hObject, eventdata, handles)

struct2var(handles.FRC);

%Creating the Circular Orbital Path
r = 5;
N = 200;
theta=linspace(pi/2,-2*pi+pi/2,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
x3center = X+10;
y3center = Y+10;

%Creating the Ovular Orbital Path
n = 1; m = 5;
theta = linspace(pi/2, -2*pi+pi/2, N);
x7center = n*cos(theta)+11;
y7center = m*sin(theta)+10;


while get(handles.FRCanimate, 'value');
    
    for k = 1:length(x3center);
        
        delete(line2); delete(ball3); delete(ball2);
        delete(line4); delete(ball7); delete(ball6);
        
        line2 = plot(handles.axes2, [10 x3center(k)], [10 y3center(k)], 'k');
        line4 = plot(handles.axes1, [11 x7center(k)], [10 y7center(k)], 'k');
        ball2 = patch(x2center+horizaxis,y2center+vertaxis, 'r', 'parent', handles.axes2);
        ball3 = patch(x3center(k)+horizaxis, y3center(k)+vertaxis, 'r', 'parent', handles.axes2);
        
        if x3center(k) > 14

            ball7 = patch(x7center(k)+horizaxis, y7center(k)+vertaxis, 'r', 'parent', handles.axes1);
            ball6 = patch(x6center+horizaxis, y6center+vertaxis, 'r', 'parent', handles.axes1);
        else
            ball6 = patch(x6center+horizaxis, y6center+vertaxis, 'r', 'parent', handles.axes1);
            ball7 = patch(x7center(k)+horizaxis, y7center(k)+vertaxis, 'r', 'parent', handles.axes1);
        end
        
        axis(handles.axes1, [0 20 0 20]);
        axis(handles.axes2, [0 20 0 20]);
        
        pause(0.01);
    end
end

%Assigning Handles
handles.FRC.ball3 = ball3; handles.FRC.ball2 = ball2;
handles.FRC.ball7 = ball7; handles.FRC.ball6 = ball6;
handles.FRC.x3center = x3center; handles.FRC.y3center = y3center;
handles.FRC.x2center = x2center; handles.FRC.y2center = y2center;
handles.FRC.x7center = x7center; handles.FRC.y7center = y7center;
handles.FRC.x6center = x6center; handles.FRC.y6center = y6center;
handles.FRC.horizaxis = horizaxis; handles.FRC.vertaxis = vertaxis;
handles.FRC.line2 = line2; handles.FRC.line4 = line4;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%------This Section is for Bond Angle Restrictions Animations----
%----------------------------------------------------------------
function BARstart_Callback(hObject, eventdata, handles)

set(handles.FJCanimate, 'visible', 'off');
set(handles.FRCanimate, 'visible', 'off');
set(handles.BARanimate, 'visible', 'on');
set(handles.BAEanimate, 'visible', 'off');
set(handles.text1, 'visible', 'off'); set(handles.text2, 'visible', 'off');
set(handles.edit1, 'visible', 'off'); set(handles.edit2, 'visible', 'off');

cla(handles.axes1)
reset(handles.axes1)
cla(handles.axes2)
reset(handles.axes2)

axis(handles.axes1, [0 20 0 20]); axis(handles.axes1, 'square');
axis(handles.axes2, [0 20 0 20]); axis(handles.axes2, 'square');
hold(handles.axes1, 'on'); hold(handles.axes2, 'on');

%Creating the Big Circle Diagrams
u = 5; v = 5;
r = linspace(0, 2*pi, 1000);
horizaxis1 = u*cos(r);
vertaxis1 = v*sin(r);

bigxcenter = 10; bigycenter = 10;
bigcircle = patch(bigxcenter+horizaxis1, bigycenter+vertaxis1,[0 0.5 0.5], 'parent', handles.axes2);

%Creating the Triangle and Oval Diagrams
trianglex = [5 11 11];
triangley = [10 15 5];
triangle = fill(trianglex, triangley, 'c', 'parent', handles.axes1);

n = 1; m = 5;
horizaxis2 = n*cos(r);
vertaxis2 = m*sin(r);
centerline = plot(handles.axes1, [5 11], [10 10], '--k');
ovalxcenter = 11; ovalycenter = 10;
oval = patch(ovalxcenter+horizaxis2, ovalycenter+vertaxis2,[0 0.5 0.5], 'parent', handles.axes1);

%Creating the Balls and Stick Model
a = .8; b = .8; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

%Presetting Vectors
xcenter = zeros(1, 15); ycenter = zeros(1, 15);
x = zeros(2, 15); y = zeros(2, 15);
axle = zeros(1, 15);
ball = zeros(1, 15);
color = ['r' 'g' 'g' 'r' 'r' 'g' 'g' 'r' 'g' 'g' 'r' 'r' 'r' 'g' 'g'];

%Creating the Balls on the Right Graph
xcenter(1) = 10; ycenter(1) = 10; %Center Red
xcenter(2) = 10+cos(pi/6)*5; ycenter(2) = 10+sin(pi/6)*5; %Top Right Green
xcenter(3) = 10+cos(5*pi/6)*5; ycenter(3) = 10+sin(5*pi/6)*5; %Top Left Green
xcenter(4) = 10; ycenter(4) = 5; %Bottom Red
xcenter(5) = 10+cos(11*pi/12)*5; ycenter(5) = 10+sin(11*pi/12)*5;
xcenter(6) = 10+cos(19*pi/12)*5; ycenter(6) = 10+sin(19*pi/12)*5;
xcenter(7) = 10+cos(3*pi/12)*5; ycenter(7) = 10+sin(3*pi/12)*5;

for k = 2:7
    x(:, k) = [10 xcenter(k)];
    y(:, k) = [10 ycenter(k)];
    axle(k) = plot(handles.axes2, x(:, k), y(:,k), 'k');
end

for k = 1:7
    ball(k) = patch(xcenter(k)+horizaxis, ycenter(k)+vertaxis, color(k), 'parent', handles.axes2);
end

%Creating the Balls on the Left Graph
xcenter(8) = 3.5; ycenter(8) = 5; %Bottom Back Red
xcenter(9) = 6; ycenter(9) = 10+sin(pi/6)*5; %Top Back Right Green
xcenter(10) = 4; ycenter(10) = 10+sin(5*pi/6)*5; %Top Back Left Green
xcenter(11) = 5; ycenter(11) = 10; %Back Center Red
xcenter(12) = 11; ycenter(12) = 10; %Front Center Red
xcenter(13) = 11+cos(11*pi/12); ycenter(13) = 10+5*sin(11*pi/12); %Front Left Red
xcenter(14) = 11+cos(19*pi/12); ycenter(14) = 10+5*sin(19*pi/12); %Front Bottom Green
xcenter(15) = 11+cos(3*pi/12); ycenter(15) = 10+5*sin(3*pi/12); %Front Top Green

x(:,8) = [5 xcenter(8)]; y(:,8) = [10 ycenter(8)];
x(:,9) = [5 xcenter(9)]; y(:,9) = [10 ycenter(9)];
x(:,10) = [5 xcenter(10)]; y(:,10) = [10 ycenter(10)];
x(:,13) = [11 xcenter(13)]; y(:,13) = [10 ycenter(13)];
x(:,14) = [11 xcenter(14)]; y(:,14) = [10 ycenter(14)];
x(:,15) = [11 xcenter(15)]; y(:,15) = [10 ycenter(15)];

axle(8) = plot(handles.axes1, x(:,8), y(:,8), 'k');
axle(9) = plot(handles.axes1, x(:,9), y(:,9), 'k');
axle(10) = plot(handles.axes1, x(:,10), y(:,10), 'k');
axle(13) = plot(handles.axes1, x(:,13), y(:,13), 'k');
axle(14) = plot(handles.axes1, x(:,14), y(:,14), 'k');
axle(15) = plot(handles.axes1, x(:,15), y(:,15), 'k');

for k = 8:15
    ball(k) = patch(xcenter(k)+horizaxis, ycenter(k)+vertaxis, color(k), 'parent', handles.axes1);
end

%Assigning Handles
handles.BAR.ball = ball; 
handles.BAR.xcenter = xcenter; handles.BAR.ycenter = ycenter;
handles.BAR.horizaxis = horizaxis; handles.BAR.vertaxis = vertaxis;
handles.BAR.axle = axle;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in BARanimate.
function BARanimate_Callback(hObject, eventdata, handles)

struct2var(handles.BAR);

%Creating the Circular Orbital Paths for the 3 Moving Circles
r = 5;
N = 200;
theta5=linspace(11*pi/12,-2*pi+11*pi/12,N);
theta6=linspace(19*pi/12,-2*pi+19*pi/12,N);
theta7=linspace(3*pi/12,-2*pi+3*pi/12,N);
rho=ones(1,N)*r;
[X5,Y5] = pol2cart(theta5,rho);
[X6,Y6] = pol2cart(theta6,rho);
[X7,Y7] = pol2cart(theta7,rho);
x5circcenter = X5+10; y5circcenter = Y5+10;
x6circcenter = X6+10; y6circcenter = Y6+10;
x7circcenter = X7+10; y7circcenter = Y7+10;

%Creating the Ovular Orbital Paths for the 3 Moving Circles
n = 1; m = 5;
theta13 = linspace(11*pi/12, -2*pi+11*pi/12, N);
theta14 = linspace(19*pi/12, -2*pi+19*pi/12, N);
theta15 = linspace(3*pi/12, -2*pi+3*pi/12, N);
x13ovalcenter = n*cos(theta13)+11; y13ovalcenter = m*sin(theta13)+10;
x14ovalcenter = n*cos(theta14)+11; y14ovalcenter = m*sin(theta14)+10;
x15ovalcenter = n*cos(theta15)+11; y15ovalcenter = m*sin(theta15)+10;

while get(handles.BARanimate, 'value');
    
    for k = 1:length(x5circcenter);
        
        delete(ball(1)); delete(ball(5:7)); delete(axle(5:7));
        delete(ball(12:15)); delete(axle(13:15));
        
        axle(5) = plot(handles.axes2, [10 x5circcenter(k)], [10 y5circcenter(k)], 'k');
        axle(6) = plot(handles.axes2, [10 x6circcenter(k)], [10 y6circcenter(k)], 'k');
        axle(7) = plot(handles.axes2, [10 x7circcenter(k)], [10 y7circcenter(k)], 'k');
        axle(13) = plot(handles.axes1, [11 x13ovalcenter(k)], [10 y13ovalcenter(k)], 'k');
        axle(14) = plot(handles.axes1, [11 x14ovalcenter(k)], [10 y14ovalcenter(k)], 'k');
        axle(15) = plot(handles.axes1, [11 x15ovalcenter(k)], [10 y15ovalcenter(k)], 'k');
        
        ball(1) = patch(xcenter(1)+horizaxis, ycenter(1)+vertaxis, 'r', 'parent', handles.axes2);
        ball(5) = patch(x5circcenter(k)+horizaxis, y5circcenter(k)+vertaxis, 'r', 'parent', handles.axes2);
        ball(6) = patch(x6circcenter(k)+horizaxis, y6circcenter(k)+vertaxis, 'g', 'parent', handles.axes2);
        ball(7) = patch(x7circcenter(k)+horizaxis, y7circcenter(k)+vertaxis, 'g', 'parent', handles.axes2);
        
        if x5circcenter(k) > 14 || x6circcenter(k) > 14 || x7circcenter(k) > 14
            ball(13) = patch(x13ovalcenter(k)+horizaxis, y13ovalcenter(k)+vertaxis, 'r', 'parent', handles.axes1);
            ball(14) = patch(x14ovalcenter(k)+horizaxis, y14ovalcenter(k)+vertaxis, 'g', 'parent', handles.axes1);
            ball(15) = patch(x15ovalcenter(k)+horizaxis, y15ovalcenter(k)+vertaxis, 'g', 'parent', handles.axes1);
            ball(12) = patch(xcenter(12)+horizaxis, ycenter(12)+vertaxis, 'r', 'parent', handles.axes1);
        else
            ball(12) = patch(xcenter(12)+horizaxis, ycenter(12)+vertaxis, 'r', 'parent', handles.axes1);
            ball(13) = patch(x13ovalcenter(k)+horizaxis, y13ovalcenter(k)+vertaxis, 'r', 'parent', handles.axes1);
            ball(14) = patch(x14ovalcenter(k)+horizaxis, y14ovalcenter(k)+vertaxis, 'g', 'parent', handles.axes1);
            ball(15) = patch(x15ovalcenter(k)+horizaxis, y15ovalcenter(k)+vertaxis, 'g', 'parent', handles.axes1);
        end
        
        axis(handles.axes1, [0 20 0 20]);
        axis(handles.axes2, [0 20 0 20]);
        
        pause(0.01);
    end
end

%Assigning Handles
handles.BAR.ball = ball; 
handles.BAR.xcenter = xcenter; handles.BAR.ycenter = ycenter;
handles.BAR.horizaxis = horizaxis; handles.BAR.vertaxis = vertaxis;
handles.BAR.axle = axle;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% ---This Section is for Bond Angle Energies Animation---------
% -------------------------------------------------------------
function BAEstart_Callback(hObject, eventdata, handles)
set(handles.FJCanimate, 'visible', 'off');
set(handles.FRCanimate, 'visible', 'off');
set(handles.BARanimate, 'visible', 'off');
set(handles.BAEanimate, 'visible', 'on');
set(handles.text1, 'visible', 'on'); set(handles.text2, 'visible', 'on');
set(handles.edit1, 'visible', 'on'); set(handles.edit2, 'visible', 'on');

cla(handles.axes1);
reset(handles.axes1);
cla(handles.axes2);
reset(handles.axes2);

axis(handles.axes1, [-180 180 -180 180]); axis(handles.axes1, 'square');
axis(handles.axes2, [0 20 0 20]); axis(handles.axes2, 'square');
hold(handles.axes1, 'on'); hold(handles.axes2, 'on');

%Creating the Big Circle Diagrams
u = 5; v = 5;
r = linspace(0, 2*pi, 1000);
horizaxis1 = u*cos(r);
vertaxis1 = v*sin(r);

bigxcenter = 10; bigycenter = 10;
bigcircle = patch(bigxcenter+horizaxis1, bigycenter+vertaxis1,[0 0.5 0.5], 'parent', handles.axes2);

%Creating the Graph
rotatingangle = linspace(-180, 180, 200);
energy = 0.5*-10^-14*(rotatingangle+192).*(rotatingangle+150).*(rotatingangle+100).*(rotatingangle+60).*(rotatingangle-60).*(rotatingangle-100).*(rotatingangle-150).*(rotatingangle-192);

plot(handles.axes1, rotatingangle, energy);
xlabel(handles.axes1, '\phi (Degrees)', 'fontsize', 16);
ylabel(handles.axes1, 'Energy', 'fontsize', 16);

axis(handles.axes1, [-180 180 -180 180]);

%Creating the Balls and Stick Model
a = .8; b = .8; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

%Presetting Vectors
xcenter = zeros(1, 7); ycenter = zeros(1, 7);
x = zeros(2, 7); y = zeros(2, 7);
axle = zeros(1, 7);
ball = zeros(1, 7);
color = ['r' 'g' 'g' 'r' 'r' 'g' 'g'];

%Creating the Balls on the Right Graph
xcenter(1) = 10; ycenter(1) = 10; %Center Red
xcenter(2) = 10+cos(pi/6)*5; ycenter(2) = 10+sin(pi/6)*5; %Top Right Green
xcenter(3) = 10+cos(5*pi/6)*5; ycenter(3) = 10+sin(5*pi/6)*5; %Top Left Green
xcenter(4) = 10; ycenter(4) = 5; %Bottom Red
xcenter(5) = 10; ycenter(5) = 5;
xcenter(6) = 10+cos(5*pi/6)*5; ycenter(6) = 10+sin(5*pi/6)*5; 
xcenter(7) = 10+cos(pi/6)*5; ycenter(7) = 10+sin(pi/6)*5; 

for k = 2:7
    x(:, k) = [10 xcenter(k)];
    y(:, k) = [10 ycenter(k)];
    axle(k) = plot(handles.axes2, x(:, k), y(:,k), 'k');
end

for k = 1:7
    ball(k) = patch(xcenter(k)+horizaxis, ycenter(k)+vertaxis, color(k), 'parent', handles.axes2);
end

%Creating the Ball on the Left Graph
u = 8; v = 8; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis2 = u*cos(r);
vertaxis2 = v*sin(r);

xcenter(8) = rotatingangle(1); ycenter(8) = energy(1);

ball(8) = patch(xcenter(8)+horizaxis2, ycenter(8)+vertaxis2, 'r', 'parent', handles.axes1);

%Assigning Handles
handles.BAE.ball = ball; 
handles.BAE.xcenter = xcenter; handles.BAE.ycenter = ycenter;
handles.BAE.horizaxis = horizaxis; handles.BAE.vertaxis = vertaxis;
handles.BAE.horizaxis2 = horizaxis2; handles.BAE.vertaxis2 = vertaxis2;
handles.BAE.axle = axle;
handles.BAE.rotatingangle = rotatingangle; handles.BAE.energy = energy;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in BAEanimate.
function BAEanimate_Callback(hObject, eventdata, handles)

struct2var(handles.BAE);

%Creating the Circular Orbital Paths for the 3 Moving Circles
r = 5;
N = 200;
theta5=linspace(3*pi/2,-2*pi+3*pi/2,N);
theta6=linspace(5*pi/6,-2*pi+5*pi/6,N);
theta7=linspace(pi/6,-2*pi+pi/6,N);
rho=ones(1,N)*r;
[X5,Y5] = pol2cart(theta5,rho);
[X6,Y6] = pol2cart(theta6,rho);
[X7,Y7] = pol2cart(theta7,rho);
x5circcenter = X5+10; y5circcenter = Y5+10;
x6circcenter = X6+10; y6circcenter = Y6+10;
x7circcenter = X7+10; y7circcenter = Y7+10;

x8circcenter = rotatingangle; y8circcenter = energy;

while get(handles.BAEanimate, 'value');
    
    for k = 1:length(x5circcenter);
        
        delete(ball(1)); delete(ball(5:8)); delete(axle(5:7));
        
        axle(5) = plot(handles.axes2, [10 x5circcenter(k)], [10 y5circcenter(k)], 'k');
        axle(6) = plot(handles.axes2, [10 x6circcenter(k)], [10 y6circcenter(k)], 'k');
        axle(7) = plot(handles.axes2, [10 x7circcenter(k)], [10 y7circcenter(k)], 'k');
        
        ball(1) = patch(xcenter(1)+horizaxis, ycenter(1)+vertaxis, 'r', 'parent', handles.axes2);
        ball(5) = patch(x5circcenter(k)+horizaxis, y5circcenter(k)+vertaxis, 'r', 'parent', handles.axes2);
        ball(6) = patch(x6circcenter(k)+horizaxis, y6circcenter(k)+vertaxis, 'g', 'parent', handles.axes2);
        ball(7) = patch(x7circcenter(k)+horizaxis, y7circcenter(k)+vertaxis, 'g', 'parent', handles.axes2);
        ball(8) = patch(x8circcenter(k)+horizaxis2, y8circcenter(k)+vertaxis2, 'r', 'parent', handles.axes1);
        
        axis(handles.axes1, [-180 180 -180 180]);
        axis(handles.axes2, [0 20 0 20]);
        
        set(handles.edit1, 'string', round(x8circcenter(k)));
        set(handles.edit2, 'string', round(x8circcenter(k)));
        
        pause(0.01);
    end
end

%Assigning Handles
handles.BAE.ball = ball; 
handles.BAE.xcenter = xcenter; handles.BAE.ycenter = ycenter;
handles.BAE.horizaxis = horizaxis; handles.BAE.vertaxis = vertaxis;
handles.BAE.horizaxis2 = horizaxis2; handles.BAE.vertaxis2 = vertaxis2;
handles.BAE.axle = axle;
handles.BAE.rotatingangle = rotatingangle; handles.BAE.energy = energy;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

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
