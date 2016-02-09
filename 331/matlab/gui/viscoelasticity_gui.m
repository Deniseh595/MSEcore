function varargout = viscoelasticity_gui(varargin)
% VISCOELASTICITY_GUI MATLAB code for viscoelasticity_gui.fig
%      VISCOELASTICITY_GUI, by itself, creates a new VISCOELASTICITY_GUI or raises the existing
%      singleton*.
%
%      H = VISCOELASTICITY_GUI returns the handle to a new VISCOELASTICITY_GUI or the handle to
%      the existing singleton*.
%
%      VISCOELASTICITY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISCOELASTICITY_GUI.M with the given input arguments.
%
%      VISCOELASTICITY_GUI('Property','Value',...) creates a new VISCOELASTICITY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before viscoelasticity_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to viscoelasticity_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help viscoelasticity_gui

% Last Modified by GUIDE v2.5 05-Dec-2013 00:46:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @viscoelasticity_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @viscoelasticity_gui_OutputFcn, ...
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


% --- Executes just before viscoelasticity_gui is made visible.
function viscoelasticity_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to viscoelasticity_gui (see VARARGIN)

fontsizeA = getappdata(0, 'fontsizeA');

% Choose default command line output for viscoelasticity_gui
handles.output = hObject;
handles.font.fontsizeA = fontsizeA;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes viscoelasticity_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = viscoelasticity_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Vstart.
function Vstart_Callback(hObject, eventdata, handles)

set(handles.Vanimate, 'visible', 'on');
fontsizeA = getappdata(0, 'fontsizeA');

cla(handles.axes1);
cla(handles.axes2);
reset(handles.axes1);
reset(handles.axes2);
axis(handles.axes1, [0 20 0 20]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');

%Creating the Ball
a = 2; b = 2; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
horizaxis = a*cos(r);
vertaxis = b*sin(r);
 
if get(handles.STbutton, 'value') == 1;
    xcenter = 10; ycenter = 16; %X and Y Centers
elseif get(handles.LTbutton, 'value') == 1;   
    xcenter = 10; ycenter = 4; %X and Y Centers   
end

ball = patch(xcenter+horizaxis,ycenter+vertaxis, 'r', 'parent', handles.axes1);

%Creating the Ground
x = [0 20]; y = [2 2];
ground = plot(handles.axes1, x, y, 'k', 'linewidth', 2);

%Assigning handles
handles.viscoelasticity.ball = ball;
handles.viscoelasticity.xcenter = xcenter;
handles.viscoelasticity.ycenter = ycenter;
handles.viscoelasticity.r = r;
handles.viscoelasticity.ground = ground;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in Vanimate.
function Vanimate_Callback(hObject, eventdata, handles)

set(handles.Vanimate, 'visible', 'off');
set(handles.description, 'string', ' ');

struct2var(handles.viscoelasticity);
struct2var(handles.font);

if get(handles.STbutton, 'value') == 1; %Short-Term Behavior Animation
    
    a(1:50) = 2;
    a(51:70) = linspace(2, 2.75, 20); %Major axis stretches
    a(71:90) = linspace(2.75, 2, 20); %Major axis shrinks
    a(91:140) = 2;
    b(1:50) = 2;
    b(51:70) = linspace(2, 1.25, 20); %Minor axis shrinks
    b(71:90) = linspace(1.25, 2, 20); %Minor axis stretches
    b(91:140) = 2;
    ycenter(1:50) = linspace(16, 4, 50);
    ycenter(51:70) = linspace(4, 3.25, 20);
    ycenter(71:90) = linspace(3.25, 4, 20);
    ycenter(91:140) = linspace(4, 16, 50);
    
    horizaxis = zeros(length(a), length(r));
    vertaxis = zeros(length(a), length(r));
    
    for j = 1:length(a);
        horizaxis(j, :) = a(j)*cos(r);
        vertaxis(j, :) = b(j)*sin(r);
    end
    
    %Movement of ball
    for k = 1:length(ycenter);
        delete(ball);
        ball = patch(xcenter+horizaxis(k,:), ycenter(k)+vertaxis(k,:), 'r', 'parent', handles.axes1);
        pause(0.02);
    end
    
    set(handles.description, 'string', 'This animation shows a ball bouncing off a solid surface in slow motion. When the ball hits the surface it deforms elastically. Because the deformation is reversible, the energy required to deform the ball as it hits the surface is almost all available to propel the ball back up into the air. The ball bounces because for the short time of contact between the ball and the substrate, it behaves as an elastic material.', 'fontsize', fontsizeA); 

elseif get(handles.LTbutton, 'value') == 1; %Long Term Behavior Animation
    
    a(1:50) = linspace(2, 2.75, 50);
    b(1:50) = linspace(2, 1.25, 50);
    ycenter(1:50) = linspace(4, 2.25, 50);
        
    horizaxis = zeros(length(a), length(r));
    vertaxis = zeros(length(a), length(r));
    
    x = [0 20]; y = [2 2];
    
    for j = 1:length(a);
        horizaxis(j, :) = a(j)*cos(r);
        vertaxis(j, :) = b(j)*sin(r);
    end
    
    %Movement of ball
    for k = 1:length(ycenter);
        delete(ball);
        delete(ground);
        
        ball = patch(xcenter+horizaxis(k,:), ycenter(k)+vertaxis(k,:), 'r', 'parent', handles.axes1);
        patch([5 5 15 15], [0.5, 2, 2, 0.5], 'w', 'edgecolor', 'w', 'parent', handles.axes1);
        ground = plot(handles.axes1, x, y, 'k', 'linewidth', 2);

        pause(0.02);
    end
    
    set(handles.description, 'string', 'This animation is a "time lapse" depiction, showing what happens when you leave silly putty sitting on a table for a very long period of time. As shown here, it gradually oozes over the surface, behaving more like a liquid than a solid. This material behaves in a "viscoelastic" manner, which means that it has solid-like behavior in some situations, and liquid-like behavior in others.', 'fontsize', fontsizeA);
    
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% ----------This Section is for Dynamic Mechanical Data---
% --------------------------------------------------------

function DMDplot_Callback(hObject, eventdata, handles)

%******mydata=dlmread('ptbadata.csv',',',1,1);
set(handles.Vanimate, 'visible', 'off');

if get(handles.ptbadata, 'value');
    
    mydata=dlmread('./Datasets/ptbadata.csv',',',1,0);
    % original needed to be changed from "1,1" to "1,0" in order to include the
    % first column of x-values
    % columns 1,4,7,10,13 are x values)
    % columns 2,3, 5,6 (etc.) are 2 different versions of y-values (G' and G")
    
    temp = [75, 85, 100, 120, 140];  
    %allocates the temperatures for the first graph
    
elseif get(handles.pvpdata, 'value');
    
    mydata=dlmread('./Datasets/pvpdata.csv',',',1,0);
    
    temp=[130, 140, 160, 180, 200];
    %allocates the temperatures for the second graph
end
plots=[];
aT=ones(1,5);
multhandles = ['multiplier1'; 'multiplier2'; 'multiplier3'; 'multiplier4'; 'multiplier5'];
for n=1:5
    tag=['data' num2str(n)];
    if get(handles.(tag), 'value');
        plots=[plots, n];
        aT(n)=str2double(get(handles.(multhandles(n,1:11)),'string'));
        legendtext{n}=[num2str(temp(n)) '^\circ C'];
    end
end

cla(handles.axes1)
cla(handles.axes2)
% clears the Axes (this step is NECESSARY because Hold is turned back on
% before graphing, even after it has been turned off)
reset(handles.axes1)
reset(handles.axes2)

hold(handles.axes1, 'on')
hold(handles.axes2, 'on')
plottype{1}='r+';
plottype{2}='b+';
plottype{3}='k+';
plottype{4}='go';
plottype{5}='bo';

for k=plots;
    xdata{k}=aT(k)*10.^mydata(:,3*k-2);  %multiply xdata by at(k)
    if get(handles.gprime,'value')
        ydata{k}=10.^mydata(:,3*k-1);
        yscale='log';
    end
    if get(handles.gdoubleprime, 'value')
        ydata{k}=10.^mydata(:,3*k);
        yscale='log';
    end
    if get(handles.gstar, 'value')
        ydata{k}=10.^(mydata(:,3*k-1).*mydata(:,3*k));
        yscale='log';
    end
    if get(handles.delta, 'value')
        ydata{k}= atan(mydata(:,3*k)./mydata(:,3*k-1));
        yscale='linear';
    end
    %Issues with this caused by the fact that negative values appear on a
    %graph with axes in logarithmic functions...changed to normal function
    plotname(k) = plot(handles.axes1, xdata{k},ydata{k},plottype{k});
    set(handles.axes1,'xscale','log')
    set(handles.axes1,'yscale',yscale)
end
loglog(handles.axes2, temp(plots), aT(plots), 'bo');
legend(handles.axes1, legendtext(plots), 'location','best')
%This is the original text, but created an error due to plotname
hold(handles.axes2, 'off')  % may not need these
hold(handles.axes1, 'off')

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
