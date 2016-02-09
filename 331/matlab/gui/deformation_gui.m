function varargout = deformation_gui(varargin)
% DEFORMATION_GUI MATLAB code for deformation_gui.fig
%      DEFORMATION_GUI, by itself, creates a new DEFORMATION_GUI or raises the existing
%      singleton*.
%
%      H = DEFORMATION_GUI returns the handle to a new DEFORMATION_GUI or the handle to
%      the existing singleton*.
%
%      DEFORMATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFORMATION_GUI.M with the given input arguments.
%
%      DEFORMATION_GUI('Property','Value',...) creates a new DEFORMATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before deformation_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to deformation_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help deformation_gui

% Last Modified by GUIDE v2.5 23-Oct-2013 23:01:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @deformation_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @deformation_gui_OutputFcn, ...
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


% --- Executes just before deformation_gui is made visible.
function deformation_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to deformation_gui (see VARARGIN)

% Choose default command line output for deformation_gui
fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');
fontsizeC = getappdata(0, 'fontsizeC');

handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;
handles.font.fontsizeC = fontsizeC;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes deformation_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = deformation_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in elasticbutton.
function elasticbutton_Callback(hObject, eventdata, handles)

set(handles.RManimate, 'visible', 'off');
set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');
struct2var(handles.font);

cla(handles.axes1); reset(handles.axes1);
cla(handles.axes2); reset(handles.axes2);

graph1 = plot(handles.axes1, [-1 -1], [-1 -1]);
graph2 = plot(handles.axes2, [-1 -1], [-1 -1]);

xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);

xlabel(handles.axes1, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes1, 'Strain', 'fontsize', fontsizeA);
xlabel(handles.axes2, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes2, 'Stress', 'fontsize', fontsizeA);

%Creating the Ball
a = 2; b = .1; %Major and Minor axis widths
r = linspace(0, 2*pi, 500);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

ball1 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes1);
ball2 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes2);

hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

x = linspace(1, 120, 400);
x2 = linspace(30, 90, 200);

y1 = linspace(0, 0, 100);
y2 = 0.0378*(x2-30);
y3 = linspace(2.268, 2.268, 100);

y = [y1 y2 y3];

for k = 1:length(x);
    
    xused = x(1:k);
    yused = y(1:k);
    
    delete(ball1); delete(ball2);
    delete(graph1); delete(graph2);
    
    graph1 = plot(handles.axes1, xused, yused, 'r', 'linewidth', 2);
    graph2 = plot(handles.axes2, xused, yused, 'r', 'linewidth', 2);
    
    ball1 = patch(horizaxis+x(k), vertaxis+y(k), 'r', 'parent', handles.axes1);
    ball2 = patch(horizaxis+x(k), vertaxis+y(k), 'r', 'parent', handles.axes2);
    
    xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
    xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);
    
    pause(0.01);
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in viscousbutton.
function viscousbutton_Callback(hObject, eventdata, handles)

set(handles.RManimate, 'visible', 'off');
set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');
struct2var(handles.font);

cla(handles.axes1); reset(handles.axes1);
cla(handles.axes2); reset(handles.axes2);

graph1 = plot(handles.axes1, [-1 -1], [-1 -1]);
graph2 = plot(handles.axes2, [-1 -1], [-1 -1]);

xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);

xlabel(handles.axes1, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes1, 'Strain', 'fontsize', fontsizeA);
xlabel(handles.axes2, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes2, 'Stress', 'fontsize', fontsizeA);

%Creating the Ball
a = 2; b = .1; %Major and Minor axis widths
r = linspace(0, 2*pi, 500);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

ball1 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes1);
ball2 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes2);

hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

x = linspace(1, 120, 400);
x2 = linspace(30, 90, 200);

y1 = linspace(0, 0, 100);
y2 = 0.0378*(x2-30);
y3 = linspace(2.268, 2.268, 100);

y4 = linspace(2.268, 2.268, 200);
y5 = linspace(0, 0, 100);

ystrain = [y1 y2 y3];
ystress = [y1 y4 y5];

for k = 1:length(x);
    delete(ball1); delete(ball2);
    delete(graph1); delete(graph2);
    
    xused = x(1:k);
    ystressused = ystress(1:k);
    ystrainused = ystrain(1:k);
    
    graph1 = plot(handles.axes1, xused, ystrainused, 'r', 'linewidth', 2);
    graph2 = plot(handles.axes2, xused, ystressused, 'r', 'linewidth', 2);
    
    ball1 = patch(horizaxis+x(k), vertaxis+ystrain(k), 'r', 'parent', handles.axes1);
    ball2 = patch(horizaxis+x(k), vertaxis+ystress(k), 'r', 'parent', handles.axes2);
    
    xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
    xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);
    
    pause(0.01);
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in viscoelasticbutton.
function viscoelasticbutton_Callback(hObject, eventdata, handles)

set(handles.RManimate, 'visible', 'off');
set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');
struct2var(handles.font);

cla(handles.axes1); reset(handles.axes1);
cla(handles.axes2); reset(handles.axes2);

graph1 = plot(handles.axes1, [-1 -1], [-1 -1]);
graph2 = plot(handles.axes2, [-1 -1], [-1 -1]);

xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);

xlabel(handles.axes1, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes1, 'Strain', 'fontsize', fontsizeA);
xlabel(handles.axes2, 'Time', 'fontsize', fontsizeA);
ylabel(handles.axes2, 'Stress', 'fontsize', fontsizeA);

%Creating the Ball
a = 2; b = .1; %Major and Minor axis widths
r = linspace(0, 2*pi, 500);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

ball1 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes1);
ball2 = patch(horizaxis, vertaxis, 'r', 'parent', handles.axes2);

hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

x = linspace(1, 120, 400);
x2 = linspace(30, 90, 200);
x3 = linspace(90, 120, 100);

y1 = linspace(0, 0, 100);
y2 = 0.0378*(x2-30);
y3 = linspace(2.268, 2.268, 100);

y4 = (x2-30).^(1/5);
y5 = 0.00252*(x3-120).^2;

ystrain = [y1 y2 y3];
ystress = [y1 y4 y5];

for k = 1:length(x);
    
    xused = x(1:k);
    ystressused = ystress(1:k);
    ystrainused = ystrain(1:k);
    
    delete(ball1); delete(ball2);
    delete(graph1); delete(graph2);
    
    graph1 = plot(handles.axes1, xused, ystrainused, 'r', 'linewidth', 2);
    graph2 = plot(handles.axes2, xused, ystressused, 'r', 'linewidth', 2);
    
    ball1 = patch(horizaxis+x(k), vertaxis+ystrain(k), 'r', 'parent', handles.axes1);
    ball2 = patch(horizaxis+x(k), vertaxis+ystress(k), 'r', 'parent', handles.axes2);
    
    xlim(handles.axes1, [0 120]); ylim(handles.axes1, [-0.1 2.5]);
    xlim(handles.axes2, [0 120]); ylim(handles.axes2, [-0.1 2.5]);
    
    pause(0.01);
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in VRdetail.
function VRdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font)
stringid = cellstr('Elastic, Viscous, and Viscoelastic Response');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

VRdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Elastic, Viscous, and Viscoleastic Responses');
VRdetailtext = uicontrol('style','text','fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(VRdetailtext, 'string', stringtext);
set(VRdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');


%----- This Section is for the Relaxation Modulus Animation -------
%------------------------------------------------------------------
function RMstart_Callback(hObject, eventdata, handles)

set(handles.RManimate, 'visible', 'on');
set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');
struct2var(handles.font);

cla(handles.axes1); reset(handles.axes1);
cla(handles.axes2); reset(handles.axes2);

xlim(handles.axes1, [0 7.5]); ylim(handles.axes1, [0 2.5]);
xlim(handles.axes2, [0 7.5]); ylim(handles.axes2, [0 2.5]);
hold(handles.axes1); hold(handles.axes2);

%Creating the Top Graph Images
rectanglex = [3.5 3.5 6.5 6.5];
rectangley = [0.5 2 2 0.5];

Gamma = text(2, 1.5, '\gamma', 'fontsize', fontsizeC, 'parent', handles.axes1);

rectangle = fill(rectanglex, rectangley, 'c', 'parent', handles.axes1);

%Creating the Labels
xlabel(handles.axes2, 't (time)', 'fontsize', fontsizeA);
ylabel(handles.axes2, '\sigma_{xy}', 'fontsize', fontsizeA);

%Creating the Bottom Graph Images
a = 0.15; b = 0.15; %Major and Minor axis widths
r = linspace(0, 2*pi, 500);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

ball = patch(horizaxis, vertaxis+2, 'r', 'parent', handles.axes2);

handles.RM.ball = ball;
handles.RM.rectangle = rectangle;
handles.RM.Gamma = Gamma;
handles.RM.horizaxis = horizaxis; handles.RM.vertaxis = vertaxis;

guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in RManimate.
function RManimate_Callback(hObject, eventdata, handles)

set(handles.RManimate, 'visible', 'off');
struct2var(handles.RM);
struct2var(handles.font);

graph = plot(handles.axes2, [-1 -1], [-1 -1]);
xlim(handles.axes1, [0 7.5]); ylim(handles.axes1, [0 2.5]);
xlim(handles.axes2, [0 7.5]); ylim(handles.axes2, [0 2.5]);
hold(handles.axes1); hold(handles.axes2);

%Creating the Labels
xlabel(handles.axes2, 't (time)', 'fontsize', fontsizeA);
ylabel(handles.axes2, '\sigma_{xy}', 'fontsize', fontsizeA);

%Setting up for the Parallelogram and New Text
delete(rectangle);
delete(Gamma);

parallelogramx = [3.5 4 7 6.5];
parallelogramy = [0.5 2 2 0.5];

parallelogram = fill(parallelogramx, parallelogramy, 'c', 'parent', handles.axes1);
Gamma = text(2, 1.5, '\gamma = \gamma_{0}', 'fontsize', fontsizeC, 'parent', handles.axes1);

%Creating the Graph
x = linspace(0, 7.5, 200);
y = 2*(0.5).^x;

for k = 1:length(x);
    
    xused = x(1:k);
    yused = y(1:k);
    delete(ball);
    delete(graph);
    
    graph = plot(handles.axes2, xused, yused, 'r', 'linewidth', 2);
    ball = patch(horizaxis+x(k), vertaxis+y(k), 'r', 'parent', handles.axes2);
    
    xlim(handles.axes1, [0 7.5]); ylim(handles.axes1, [0 2.5]);
    xlim(handles.axes2, [0 7.5]); ylim(handles.axes2, [0 2.5]);
    
    xlabel(handles.axes2, 't (time)', 'fontsize', fontsizeA);
    ylabel(handles.axes2, '\sigma_{xy}', 'fontsize', fontsizeA);
    
    pause(0.01);
    
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in RMdetail.
function RMdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Relaxation Modulus');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

RMdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Relaxation Modulus');
RMdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(RMdetailtext, 'string', stringtext);
set(RMdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --------This Section is for Dynamic Mechanical Spectroscopy
% ------------------------------------------------------------
function DMSstart_Callback(hObject, eventdata, handles)

set(handles.DMSelastic, 'visible', 'on');
set(handles.DMSviscous, 'visible', 'on');
set(handles.DMSviscoelastic, 'visible', 'on');
set(handles.RManimate, 'visible', 'off');
struct2var(handles.font);

cla(handles.axes1); reset(handles.axes1);
cla(handles.axes2); reset(handles.axes2);

axis(handles.axes1, [0 7.5 0 3]);
axis(handles.axes2, [0 5*pi -1.5 1.5]);
hold(handles.axes1, 'on'); hold(handles.axes2, 'on');

%Making the Graph
x = 0:0.01:5*pi;
y = sin(x);

graph = plot(handles.axes2, x, y);

%Making the Text
a1 = 0.3; b1 = 0.3; %Major and Minor axis widths
a2 = 0.2; b2 = 0.2;
r = linspace(0, 2*pi, 500);
horizaxis1 = a1*cos(r); vertaxis1 = b1*sin(r);
horizaxis2 = a2*cos(r); vertaxis2 = b2*sin(r);

ball1 = patch(horizaxis1+6.25, vertaxis1+2.5, 'r', 'parent', handles.axes1);
ball2 = patch(horizaxis2+6, vertaxis2+1.5, 'b', 'parent', handles.axes1);

text1 = text(4.5, 2.5, 'Stress ', 'fontsize', fontsizeC, 'parent', handles.axes1);
text2 = text(4.5, 1.5, 'Strain ', 'fontsize', fontsizeC, 'parent', handles.axes1);

%Making the Mechanical Shape
bar = fill([1.8 2.2 2.2 1.8], [0.2 0.2 2.8 2.8], 'k', 'parent', handles.axes1);

%Top Curve
a3 = 0.2; b3 = 0.06;
horizaxis3 = a3*cos(r); vertaxis3 = b3*sin(r);
ball3 = patch(horizaxis3+2, vertaxis3+2.8, [0.6 0.6 0.6], 'parent', handles.axes1);

%Bottom Curve
ball4 = patch(horizaxis3+2, vertaxis3+.2, [0 0 0], 'parent', handles.axes1);

%Creating the Cylinder
a5 = 1.4; b5 = 0.2;
horizaxis5 = a5*cos(r); vertaxis5 = b5*sin(r);
ball5 = patch(horizaxis5+2, vertaxis5+1.2, [0.9 0.9 0.9], 'parent', handles.axes1);
mainbody = fill([0.6 3.4 3.4 0.6], [1.2 1.2 1.8 1.8], [0.9 0.9 0.9], 'edgecolor', [0.9 0.9 0.9], 'parent', handles.axes1);

a6 = 1.38; b6 = 0.2;
horizaxis6 = a6*cos(r); vertaxis6 = b6*sin(r);
ball6 = patch(horizaxis6+2, vertaxis6+1.4, [0 0.7 0.95], 'edgecolor', [0 0.2 0.95], 'parent', handles.axes1);
bluebody = fill([0.62 3.38 3.38 0.62], [1.4 1.4 1.8 1.8], [0 0.7 0.95], 'edgecolor', [0 0.7 0.95], 'parent', handles.axes1);

ball7 = patch(horizaxis5+2, vertaxis5+1.6, [0.9 0.9 0.9], 'parent', handles.axes1);
mainbody = fill([0.6 3.4 3.4 0.6], [1.6 1.6 1.8 1.8], [0.9 0.9 0.9], 'edgecolor', [0.9 0.9 0.9], 'parent', handles.axes1);

ball8 = patch(horizaxis5+2, vertaxis5+1.8, [0.6 0.6 0.6], 'parent', handles.axes1);

%Recovering the Top Curve
blackbody = fill([1.8 2.2 2.2 1.8], [1.88 1.88 2.2 2.2], 'k', 'parent', handles.axes1);
ball9 = patch(horizaxis3+2, vertaxis3+1.88, 'k', 'parent', handles.axes1);

%Creating the Center Line
x = [1.85 2.15];
y = [1.5 1.5];
line = plot(handles.axes1, x, y, 'k');

%Creating the Boxes
redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
bluebox = fill([1.95 2.05 2.05 1.95], [.98 .98 1.19 1.19], 'b', 'parent', handles.axes1);

handles.DMS.redbox = redbox;

guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in DMSelastic.
function DMSelastic_Callback(hObject, eventdata, handles)

set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');

struct2var(handles.DMS);

a1 = 0.4; b1 = 0.2; %Major and Minor axis widths
a2 = 0.24; b2 = 0.12;
r = linspace(0, 2*pi, 500);
horizaxis1 = a1*cos(r); vertaxis1 = b1*sin(r);
horizaxis2 = a2*cos(r); vertaxis2 = b2*sin(r);

ball1 = patch(horizaxis1, vertaxis1, 'r', 'parent', handles.axes2);
ball2 = patch(horizaxis2, vertaxis2, 'b', 'parent', handles.axes2);

x = linspace(0, 5*pi, 400);
y = sin(x);

counter = 1;

for k = 1:length(x);
    delete(ball1); delete(ball2);
    
    ball1 = patch(horizaxis1+x(k), vertaxis1+y(k), 'r', 'parent', handles.axes2);
    ball2 = patch(horizaxis2+x(k), vertaxis2+y(k), 'b', 'parent', handles.axes2);
    
    if mod(counter, 40) == 10;
        delete(redbox);
        redbox = fill([2.1 2.2 2.2 2.1], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 20;
        delete(redbox);
        redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 30;
        delete(redbox);
        redbox = fill([1.8 1.9 1.9 1.8], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 0;
        delete(redbox);
        redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    end
    
    counter = counter+1;
    
    pause(0.01);  
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in DMSviscous.
function DMSviscous_Callback(hObject, eventdata, handles)

set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');

struct2var(handles.DMS);

a1 = 0.4; b1 = 0.2; %Major and Minor axis widths
a2 = 0.24; b2 = 0.12;
r = linspace(0, 2*pi, 500);
horizaxis1 = a1*cos(r); vertaxis1 = b1*sin(r);
horizaxis2 = a2*cos(r); vertaxis2 = b2*sin(r);

ball1 = patch(horizaxis1, vertaxis1, 'r', 'parent', handles.axes2);
ball2 = patch(horizaxis2, vertaxis2, 'b', 'parent', handles.axes2);

x1 = linspace(-pi/2, 5*pi, 450);
y1 = sin(x1);
x2 = linspace(0, 5*pi+pi/2, 450);
y2 = sin(x2);

counter = 1;

for k = 1:length(x1);
    delete(ball1); delete(ball2);
    
    ball1 = patch(horizaxis1+x1(k), vertaxis1+y1(k), 'r', 'parent', handles.axes2);
    ball2 = patch(horizaxis2+x2(k), vertaxis2+y2(k), 'b', 'parent', handles.axes2);
    
    if mod(counter, 40) == 10;
        delete(redbox);
        redbox = fill([2.1 2.2 2.2 2.1], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 20;
        delete(redbox);
        redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 30;
        delete(redbox);
        redbox = fill([1.8 1.9 1.9 1.8], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    elseif mod(counter, 40) == 0;
        delete(redbox);
        redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
    end
    
    counter = counter+1;
    
    pause(0.01);  
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in DMSviscoelastic.
function DMSviscoelastic_Callback(hObject, eventdata, handles)

set(handles.DMSelastic, 'visible', 'off');
set(handles.DMSviscous, 'visible', 'off');
set(handles.DMSviscoelastic, 'visible', 'off');

struct2var(handles.DMS);

%Determining the Difference in Shift
angle = str2double(get(handles.anglebox, 'string'));

if angle >= 0 & angle <= 90;
    
    radians = round(angle)/360*2*pi;
    redstart = -radians;
    bluefinish = 5*pi+radians;
    
    
    a1 = 0.4; b1 = 0.2; %Major and Minor axis widths
    a2 = 0.24; b2 = 0.12;
    r = linspace(0, 2*pi, 500);
    horizaxis1 = a1*cos(r); vertaxis1 = b1*sin(r);
    horizaxis2 = a2*cos(r); vertaxis2 = b2*sin(r);
    
    ball1 = patch(horizaxis1, vertaxis1, 'r', 'parent', handles.axes2);
    ball2 = patch(horizaxis2, vertaxis2, 'b', 'parent', handles.axes2);
    
    x1 = linspace(redstart, 5*pi, 450);
    y1 = sin(x1);
    x2 = linspace(0, bluefinish, 450);
    y2 = sin(x2);
    
    counter = 1;
    
    for k = 1:length(x1);
        delete(ball1); delete(ball2);
        
        ball1 = patch(horizaxis1+x1(k), vertaxis1+y1(k), 'r', 'parent', handles.axes2);
        ball2 = patch(horizaxis2+x2(k), vertaxis2+y2(k), 'b', 'parent', handles.axes2);
        
        if mod(counter, 40) == 10;
            delete(redbox);
            redbox = fill([2.1 2.2 2.2 2.1], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
        elseif mod(counter, 40) == 20;
            delete(redbox);
            redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
        elseif mod(counter, 40) == 30;
            delete(redbox);
            redbox = fill([1.8 1.9 1.9 1.8], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
        elseif mod(counter, 40) == 0;
            delete(redbox);
            redbox = fill([1.95 2.05 2.05 1.95], [1.41 1.41 1.59 1.59], 'r', 'parent', handles.axes1);
        end
        
        pause(0.01);
        counter = counter+1;
    end
else
    infofig = figure('position', [100, 100, 400, 300]);
    
    infotext1 = uicontrol('style','text', 'fontsize', fontsizeC, 'fontweight', 'bold','horizontalalignment', 'left');
    set(infotext1, 'string', 'Error, you have input an invalid angle. Please press the reset button and input an angle between 0 and 90 degrees.');
    set(infotext1, 'position', [50 150 300 100], 'units', 'normalized');
    
end

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
