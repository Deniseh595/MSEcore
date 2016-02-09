function varargout = living_polymerizations_gui(varargin)
% LIVING_POLYMERIZATIONS_GUI MATLAB code for living_polymerizations_gui.fig
%      LIVING_POLYMERIZATIONS_GUI, by itself, creates a new LIVING_POLYMERIZATIONS_GUI or raises the existing
%      singleton*.
%
%      H = LIVING_POLYMERIZATIONS_GUI returns the handle to a new LIVING_POLYMERIZATIONS_GUI or the handle to
%      the existing singleton*.
%
%      LIVING_POLYMERIZATIONS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIVING_POLYMERIZATIONS_GUI.M with the given input arguments.
%
%      LIVING_POLYMERIZATIONS_GUI('Property','Value',...) creates a new LIVING_POLYMERIZATIONS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before living_polymerizations_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to living_polymerizations_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help living_polymerizations_gui

% Last Modified by GUIDE v2.5 11-Sep-2013 18:46:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @living_polymerizations_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @living_polymerizations_gui_OutputFcn, ...
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


% --- Executes just before living_polymerizations_gui is made visible.
function living_polymerizations_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to living_polymerizations_gui (see VARARGIN)

% Choose default command line output for living_polymerizations_gui
fontsizeA = getappdata(0, 'fontsizeA');

handles.font.fontsizeA = fontsizeA;

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes living_polymerizations_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = living_polymerizations_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in initiationbutton.
function initiationbutton_Callback(hObject, eventdata, handles)

set(handles.initiationbutton, 'visible', 'off');
set(handles.propagationbutton, 'visible', 'on');
struct2var(handles.font);

set(handles.textbox, 'string', 'At the beginning of the reaction, initiators (represented by the circles outlined in green) and monomers (represented by the red circles) are added to the reaction vessel. In most cases the reaction is carried out in a non-reactive carrier solvent');

xlim([0, 36]); ylim([0, 21]);
r = 0.5;
N = 1000;
color1 = 'r';
color2 = 'g';
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

randx = zeros(1, 70);
randy = zeros(1, 70);

%Creating the Initial Monomers
for k = 1:60
    randx = randi([4 32]);
    randy = randi([3 18]);
    
    xcenter(k) = randx;
    ycenter(k) = randy;
end

hold on
h = zeros(1, length(xcenter));
for k = 1:length(xcenter); 
        Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
        h(k)=fill(Xnew,Ynew,color1);
        pause(0.01)

end

for k = 1:5
    randx = randi([4 32]);
    randy = randi([3 18]);
    
    xgreen(k) = randx;
    ygreen(k) = randy; 
end

q = zeros(1, length(xgreen));
j = zeros(1, length(xgreen));

for k = 1: length(xgreen);
    Xnew=X+xgreen(k); Ynew=Y+ygreen(k);
    j(k)=fill(Xnew,Ynew,color1);
    q(k) = plot(Xnew, Ynew, color2, 'linewidth', 2);
    pause(0.01)
end

handles.LP.h = h;
handles.LP.q = q;
handles.LP.xcenter = xcenter; handles.LP.ycenter = ycenter;
handles.LP.xgreen = xgreen; handles.LP.ygreen = ygreen;
handles.LP.X = X; handles.LP.Y = Y;
handles.LP.color1 = color1; handles.LP.color2 = color2;

guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in propagationbutton.
function propagationbutton_Callback(hObject, eventdata, handles)

set(handles.propagationbutton, 'visible', 'off');
set(handles.terminationbutton, 'visible', 'on');

struct2var(handles.font);
struct2var(handles.LP);

set(handles.textbox, 'string', 'Monomers add randomly to the different molecules. If all of the molecules were initiated at the same time, the molecules all propagate at the same rate, and have similar (but not completely identical) lengths.');

if get(handles.fastbutton, 'value') == 1;
    pausetime1 = 0;
    pausetime2 = 0.01;
else
    pausetime1 = 0.01;
    pausetime2 = 0;
end

monomertracker = ones(1, length(xcenter)); %Creating a Vector to Track moving Monomers

while sum(monomertracker) > 0;
    
    p = randi(length(xcenter));
    
    if monomertracker(p) > 0
        
        i = randi(2);
        if i == 1;
            u = rand*-1;
        elseif i == 2;
            u = rand*1;
        end
        
        i = randi(2);
        if i == 1;
            v = sqrt(1-u^2)*-1;
        elseif i == 2;
            v = sqrt(1-u^2);
        end
        
        i = randi(5); %Randomly Choosing an Initiator to Move to
        
        newx = xgreen(i)+u; %Creating the new X and Y Coordinates
        newy = ygreen(i)+v;
        
        xvector = linspace(xcenter(p), newx, 15);
        yvector = linspace(ycenter(p), newy, 15);
        
        for k = 1:length(xvector);
            delete(h(p));
            Xnew=X+xvector(k); Ynew=Y+yvector(k);
            h(p)=fill(Xnew,Ynew,color1);
            
            pause(pausetime1)
        end
        
        xgreen(i) = newx;
        ygreen(i) = newy;
        Xnew = X+xgreen(i); Ynew = Y+ygreen(i);
        delete(q(i));
        q(i) = plot(Xnew, Ynew, color2, 'linewidth', 2);
        
        monomertracker(p) = 0;
        
    end 
    
    pause(pausetime2);
    
end

handles.LP.q = q;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in terminationbutton.
function terminationbutton_Callback(hObject, eventdata, handles)

set(handles.terminationbutton, 'visible', 'off');
struct2var(handles.font);
struct2var(handles.LP);

set(handles.textbox, 'string', 'Termination corresponds to the deactivation of the propagating species. If additional monomer is added after this point, it will no longer add to the polymer chains');

delete(q);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

function resetbutton_Callback(hObject, eventdata, handles)

set(handles.initiationbutton, 'visible', 'on');
set(handles.propagationbutton, 'visible', 'off');
set(handles.terminationbutton, 'visible', 'off');
set(handles.textbox, 'string', ' ');
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
