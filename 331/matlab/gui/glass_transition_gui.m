function varargout = glass_transition_gui(varargin)
% GLASS_TRANSITION_GUI MATLAB code for glass_transition_gui.fig
%      GLASS_TRANSITION_GUI, by itself, creates a new GLASS_TRANSITION_GUI or raises the existing
%      singleton*.
%
%      H = GLASS_TRANSITION_GUI returns the handle to a new GLASS_TRANSITION_GUI or the handle to
%      the existing singleton*.
%
%      GLASS_TRANSITION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GLASS_TRANSITION_GUI.M with the given input arguments.
%
%      GLASS_TRANSITION_GUI('Property','Value',...) creates a new GLASS_TRANSITION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before glass_transition_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to glass_transition_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help glass_transition_gui

% Last Modified by GUIDE v2.5 30-Jan-2014 13:00:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @glass_transition_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @glass_transition_gui_OutputFcn, ...
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


% --- Executes just before glass_transition_gui is made visible.
function glass_transition_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to glass_transition_gui (see VARARGIN)

% Choose default command line output for glass_transition_gui
handles.output = hObject;

fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');
fontsizeC = getappdata(0, 'fontsizeC');
fontsizeD = getappdata(0, 'fontsizeD');

handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;
handles.font.fontsizeC = fontsizeC;
handles.font.fontsizeD = fontsizeD;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes glass_transition_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = glass_transition_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GTGstart.
function GTGstart_Callback(hObject, eventdata, handles)

struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 16 0 16], 'square');
hold on;

%Creating the Lines
topline = plot(handles.axes1, [14 2], [14 2], '--r');
bottomline = plot(handles.axes1, [15 2], [8 2], '--r');

fastpath1 = plot(handles.axes1, [14 10], [14 10], 'r', 'linewidth', 2);
fastpath2 = plot(handles.axes1, [10 2], [10 6], 'r', 'linewidth', 2);

slowpath1 = plot(handles.axes1, [10 8.5], [10 8.5], 'r', 'linewidth', 2);
slowpath2 = plot(handles.axes1, [8.5 2], [8.5 5], 'r', 'linewidth', 2);

%Creating the Words
actualvolume = text(10, 15, 'Actual Volume', 'fontsize', fontsizeA);
occupiedvolume = text(11, 3, 'Occupied Volume', 'color', 'b', 'fontsize', fontsizeA);
freevolume = text(2, 13, 'V_{f} = Actual Volume - Occupied Volume', 'fontsize', fontsizeA);
vf = text(11, 8.5, 'V_{f}', 'fontsize', fontsizeB);

%Creating the Line
vline = plot([12 12], [12, 6.6], 'k', 'linewidth', 1);

%Creating the Ball
a = 0.4; b = 0.4; %Major and Minor axis widths
r = linspace(0, 2*pi, 500);
horizaxis = a*cos(r);
vertaxis = b*sin(r);

ball = patch(horizaxis+12, vertaxis+12, 'b', 'parent', handles.axes1);

handles.GTG.ball = ball; handles.GTG.vf = vf; handles.GTG.vline = vline;
handles.GTG.horizaxis = horizaxis; handles.GTG.vertaxis = vertaxis;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in GTGslow.
function GTGslow_Callback(hObject, eventdata, handles)

struct2var(handles.font);
struct2var(handles.GTG);

hold on;

slowpathx = [linspace(12, 8.5, 71) linspace(8.5, 2, 129)];
slowpathy = [linspace(12, 8.5, 71) linspace(8.5, 5, 129)];

linebottomx = linspace(12, 2, 200);
linebottomy = linspace(6.6, 2, 200);

vfx = [linspace(11, 7.5, 71) linspace(7.5, 1, 129)];
vfy = [linspace(8.5, 6, 71) linspace(6, 3.5, 129)];

for k = 1:length(slowpathx)
    delete(ball); delete(vf); delete(vline);
    vline = plot([slowpathx(k) linebottomx(k)], [slowpathy(k) linebottomy(k)], 'k');
    ball = patch(horizaxis+slowpathx(k), vertaxis+slowpathy(k), 'b');
    vf = text(vfx(k), vfy(k), 'V_{f}', 'fontsize', fontsizeB);
    pause(0.01);
    
    if k == 71;
        tgline = plot([slowpathx(k) linebottomx(k)], [slowpathy(k) linebottomy(k)], 'k');
        tg = text(slowpathx(k), 3.5, 'T_{g}', 'fontsize', fontsizeB);
    end
end

tinf = text(slowpathx(k), 1, 'T_{\infty}', 'fontsize', fontsizeB);

handles.GTG.ball = ball; handles.GTG.vf = vf; handles.GTG.vline = vline;
handles.GTG.horizaxis = horizaxis; handles.GTG.vertaxis = vertaxis;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture
    
% --- Executes on button press in GTGfast.
function GTGfast_Callback(hObject, eventdata, handles)
struct2var(handles.font);
struct2var(handles.GTG);

hold on;

fastpathx = [linspace(12, 10, 40) linspace(10, 2, 160)];
fastpathy = [linspace(12, 10, 40) linspace(10, 6, 160)];

linebottomx = linspace(12, 2, 200);
linebottomy = linspace(6.6, 2, 200);

vfx = [linspace(11, 7.5, 40) linspace(7.5, 1, 160)];
vfy = [linspace(8.5, 6, 40) linspace(6, 3.5, 160)];

for k = 1:length(fastpathx)
    delete(ball); delete(vf); delete(vline);
    vline = plot([fastpathx(k) linebottomx(k)], [fastpathy(k) linebottomy(k)], 'k');    
    ball = patch(horizaxis+fastpathx(k), vertaxis+fastpathy(k), 'b');
    vf = text(vfx(k), vfy(k), 'V_{f}', 'fontsize', fontsizeB);
    pause(0.01);
    
    if k == 40;
        tgline = plot([fastpathx(k) linebottomx(k)], [fastpathy(k) linebottomy(k)], 'k');
        tg = text(fastpathx(k), 4.5, 'T_{g}', 'fontsize', fontsizeB);
    end
end

tinf = text(fastpathx(k), 1, 'T_{\infty}', 'fontsize', fontsizeB);

handles.GTG.ball = ball; handles.GTG.vf = vf; handles.GTG.vline = vline;
handles.GTG.horizaxis = horizaxis; handles.GTG.vertaxis = vertaxis;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in GTstart.
function GTstart_Callback(hObject, eventdata, handles)

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 8 0 8], 'square');
hold(handles.axes1, 'on');

%Creating the Grid
xh = [1 7]; yv = [1 7];
yh = zeros(1, 7); xv = zeros(1, 7);

for k = 1:7
    yh(k) = k;
    xv(k) = k;
    
    plot(xh, [yh(k) yh(k)]);
    plot([xv(k) xv(k)], yv);
    
end

%Creating the Balls

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
