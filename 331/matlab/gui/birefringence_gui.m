function varargout = birefringence_gui(varargin)
% BIREFRINGENCE_GUI MATLAB code for birefringence_gui.fig
%      BIREFRINGENCE_GUI, by itself, creates a new BIREFRINGENCE_GUI or raises the existing
%      singleton*.
%
%      H = BIREFRINGENCE_GUI returns the handle to a new BIREFRINGENCE_GUI or the handle to
%      the existing singleton*.
%
%      BIREFRINGENCE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIREFRINGENCE_GUI.M with the given input arguments.
%
%      BIREFRINGENCE_GUI('Property','Value',...) creates a new BIREFRINGENCE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before birefringence_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to birefringence_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help birefringence_gui

% Last Modified by GUIDE v2.5 21-Nov-2013 12:13:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @birefringence_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @birefringence_gui_OutputFcn, ...
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


% --- Executes just before birefringence_gui is made visible.
function birefringence_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to birefringence_gui (see VARARGIN)

fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');

handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;

psi = str2double(get(handles.psiedit, 'string'))/360*2*pi;
dphi = str2double(get(handles.dpedit, 'string'))/360*2*pi;

axis(handles.axes1, [-10 10 -10 10], 'square');
axis(handles.axes2, [0 7 0 3.5]);
hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

%Creating Axes on Axis 1
staticxaxis = plot(handles.axes1, [-10 10], [0 0], 'k', 'linewidth', 2);
staticyaxis = plot(handles.axes1, [0 0], [-10 10], 'k', 'linewidth', 2);

mobilexaxis = plot(handles.axes1, [-10*sin(psi) 10*sin(psi)], [10*cos(psi) -10*cos(psi)], 'k');
mobileyaxis = plot(handles.axes1, [-10*cos(psi) 10*cos(psi)], [-10*sin(psi) 10*sin(psi)], 'k');

handles.B.mobilexaxis = mobilexaxis;
handles.B.mobileyaxis = mobileyaxis;

%Creating Images on Axis 2 representing the Analyzer, Sample, and Polarizer
analyzer = fill([2.5 6.5 6.5 2.5], [3.2 3.2 3.1 3.1], 'k', 'parent', handles.axes2);
sample = patch([2.5 6.5 6.5 2.5], [2.7 2.7 1.7 1.7], 'k', 'parent', handles.axes2);
polarizer = patch([2.5 6.5 6.5 2.5], [1.3 1.3 1.2 1.2], 'k', 'parent', handles.axes2);

handles.B.analyzer = analyzer;
handles.B.sample = sample;
handles.B.polarizer = polarizer;

%Creating the Light Source Image
a = .6; b = .6; %Major and Minor axis widths
r = linspace(0, 2*pi, 1000);
width = a*cos(r);
height = b*sin(r);

light = patch(4.5+width, height, 'y', 'parent', handles.axes2); %Drawing the Ball

%Creating the Text
atext = text(0.5, 3.1, 'Analyzer', 'parent', handles.axes2);
stext = text(0.5, 2.3, 'Sample', 'parent', handles.axes2);
ptext = text(0.5, 1.3, 'Polarizer', 'parent', handles.axes2);

% Choose default command line output for birefringence_gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes birefringence_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = birefringence_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in BAanimate.
%function BAanimate_Callback(hObject, eventdata, handles)

function birefringencebuttongroup_SelectionChangeFcn(hObject, eventdata, handles)

%Cases for the Button Group
switch get(eventdata.NewValue, 'Tag')
    
    % ----Case for the Analyzer-----------
    % ------------------------------------
    case 'BAanimate'
        
        struct2var(handles.B);
        struct2var(handles.font);
        
        if get(handles.BAanimate, 'value') == 1;
            %Clearing and Presetting Axes
            cla(handles.axes1);
            axis(handles.axes1, [-10 10 -10 10]);
            hold(handles.axes1, 'on');
            set(analyzer, 'facecolor', 'r');
            set(sample, 'facecolor', 'k');
            set(polarizer, 'facecolor', 'k');
            
            psi = str2double(get(handles.psiedit, 'string'))/360*2*pi;
            dphi = str2double(get(handles.dpedit, 'string'))/360*2*pi;
            
            staticxaxis = plot(handles.axes1, [-10 10], [0 0], 'k', 'linewidth', 2);
            staticyaxis = plot(handles.axes1, [0 0], [-10 10], 'k', 'linewidth', 2);
            
            mobilexaxis = plot(handles.axes1, [-10*sin(psi) 10*sin(psi)], [10*cos(psi) -10*cos(psi)], 'k');
            mobileyaxis = plot(handles.axes1, [-10*cos(psi) 10*cos(psi)], [-10*sin(psi) 10*sin(psi)], 'k');
            
            %Calculating the value of Psi that will be used in the Motion
            psimod = str2double(get(handles.psiedit, 'string'));
            psimod2 = psimod-90*floor(psimod/90); %Conversion to value between 0 and 90
            psifinal = psimod2/360*2*pi; %Conversion to Radians
            
            %This If-Statement determines the Amplitude of the Red Ball
            if psifinal <= pi/4;
                amplitude = 10*sin(psifinal);
            elseif psifinal > pi/4;
                amplitude = 10*cos(psifinal);
            end
            
            %This section presets a movement vector for the "ball" and creates the ball
            a = 0.5; b = 0.5; %Major and Minor axis widths
            r = linspace(0, 2*pi, 1000);
            width = a*cos(r);
            height = b*sin(r);
            
            xcenter = 0;
            ycenter = 0;
            
            redball = patch(xcenter+width, ycenter+height, 'r', 'parent', handles.axes1); %Drawing the Ball
            
            theta = linspace(pi/2, 5*pi/2, 100);
            
            handles.B.mobilexaxis = mobilexaxis;
            handles.B.mobileyaxis = mobileyaxis;
            handles.B.analyzer = analyzer;
            handles.B.sample = sample;
            handles.B.polarizer = polarizer;
            guidata(hObject, handles);
            
        end
        
        %This While Loop only continues as long as the Analyzer Button is pressed
        %down
        while get(handles.BAanimate, 'value') == 1;
            
            for k = 1:length(theta);
                delete(redball);
                redball = patch(width, amplitude*cos(theta(k))+height, 'r', 'parent', handles.axes1);
                
                pause(0.01); 
            end
            
        end
        
    % ----Case for the Sample Filter------
    % ------------------------------------
        
    case 'BSanimate'
        struct2var(handles.B);
        struct2var(handles.font);
        
        if get(handles.BSanimate, 'value') == 1;
            %Clearing and Presetting Axes
            cla(handles.axes1);
            axis(handles.axes1, [-10 10 -10 10]);
            hold(handles.axes1, 'on');
            set(analyzer, 'facecolor', 'k');
            set(sample, 'facecolor', 'r');
            set(polarizer, 'facecolor', 'k');
            
            psi = str2double(get(handles.psiedit, 'string'))/360*2*pi;
            dphi = str2double(get(handles.dpedit, 'string'))/360*2*pi;
            
            staticxaxis = plot(handles.axes1, [-10 10], [0 0], 'k', 'linewidth', 2);
            staticyaxis = plot(handles.axes1, [0 0], [-10 10], 'k', 'linewidth', 2);
            
            mobilexaxis = plot(handles.axes1, [-10*sin(psi) 10*sin(psi)], [10*cos(psi) -10*cos(psi)], 'k');
            mobileyaxis = plot(handles.axes1, [-10*cos(psi) 10*cos(psi)], [-10*sin(psi) 10*sin(psi)], 'k');
            
            %Calculating the value of Psi that will be used in the Motion
            psimod = str2double(get(handles.psiedit, 'string'));
            psimod2 = psimod-90*floor(psimod/90); %Conversion to value between 0 and 90
            psifinal = psimod2/360*2*pi; %Conversion to Radians
            
            %This If-Statement determines the Amplitude of the Red Ball
            if psifinal <= pi/4;
                redampx = 10*sin(psifinal); %Max "X" amplitude
                redampy = 10*cos(psifinal); %Max "Y" amplitude
            elseif psifinal > pi/4;
                redampx = 10*sin(psifinal);
                redampy = 10*cos(psifinal);
            end
            
            blueamp1 = 10*sin(psi); %Amplitude of first Blue Ball
            blueamp2 = 10*cos(psi); %Amplitude of second Blue Ball
            
            %This section presets a movement vector for the "ball" and creates the ball
            a = 0.5; b = 0.5; %Major and Minor axis widths
            r = linspace(0, 2*pi, 1000);
            width = a*cos(r);
            height = b*sin(r);
            
            xcenter = 0;
            ycenter = 0;
            
            %Drawing the Balls
            redball = patch(xcenter+width, ycenter+height, 'r', 'parent', handles.axes1); 
            blueball1 = patch(xcenter+width, ycenter+height, 'b', 'parent', handles.axes1);
            blueball2 = patch(xcenter+width, ycenter+height, 'b', 'parent', handles.axes1);
            
            %Creating the Vector Movements
            
            rtheta = linspace(0, -2*pi, 100); %thetavector for red
            b1thetax = linspace(0, -2*pi, 100); %thetavector for blue 1 x
            b1thetay = linspace(-pi, -3*pi, 100); %thetavector for blue 1 y
            b2theta = linspace(pi/2, 5*pi/2, 100);
            
            shiftangle=[sin(psifinal) -cos(psifinal); cos(psifinal) sin(psifinal)];
            
            for k = 1: length(rtheta);
                redballx(k) = redampx*sin(rtheta(k));
                redbally(k) = redampy*cos(rtheta(k));
            end
            
            redballdim = [redballx' redbally']*shiftangle;
            
            handles.B.mobilexaxis = mobilexaxis;
            handles.B.mobileyaxis = mobileyaxis;
            handles.B.analyzer = analyzer;
            handles.B.sample = sample;
            handles.B.polarizer = polarizer;
            guidata(hObject, handles);
            
        end
        
        %This While Loop only continues as long as the Analyzer Button is pressed
        %down
        while get(handles.BSanimate, 'value') == 1;
            
            for k = 1:length(rtheta);
                delete(redball); delete(blueball1); delete(blueball2);
                redball = patch(redballdim(k, 1)+width, redballdim(k, 2)+height, 'r', 'parent', handles.axes1);
                blueball1 = patch(blueamp1*sin(psi)*sin(b1thetax(k))+width, blueamp1*cos(psi)*sin(b1thetay(k))+height, 'b', 'parent', handles.axes1);
                blueball2 = patch(blueamp2*cos(psi)*sin(b2theta(k))+width, blueamp2*sin(psi)*sin(b2theta(k))+height, 'b', 'parent', handles.axes1);
                
                pause(0.01); 
            end
            
        end
    
    % ----Case for the Polarizer Filter---
    % ------------------------------------
    case 'BPanimate'
        struct2var(handles.B);
        struct2var(handles.font);
        
        if get(handles.BPanimate, 'value') == 1;
            %Clearing and Presetting Axes
            cla(handles.axes1);
            axis(handles.axes1, [-10 10 -10 10]);
            hold(handles.axes1, 'on');
            set(analyzer, 'facecolor', 'k');
            set(sample, 'facecolor', 'k');
            set(polarizer, 'facecolor', 'r');
            
            psi = str2double(get(handles.psiedit, 'string'))/360*2*pi;
            dphi = str2double(get(handles.dpedit, 'string'))/360*2*pi;
            
            staticxaxis = plot(handles.axes1, [-10 10], [0 0], 'k', 'linewidth', 2);
            staticyaxis = plot(handles.axes1, [0 0], [-10 10], 'k', 'linewidth', 2);
            
            mobilexaxis = plot(handles.axes1, [-10*sin(psi) 10*sin(psi)], [10*cos(psi) -10*cos(psi)], 'k');
            mobileyaxis = plot(handles.axes1, [-10*cos(psi) 10*cos(psi)], [-10*sin(psi) 10*sin(psi)], 'k');
            
            %Calculating the value of Psi that will be used in the Motion
            psimod = str2double(get(handles.psiedit, 'string'));
            psimod2 = psimod-90*floor(psimod/90); %Conversion to value between 0 and 90
            psifinal = psimod2/360*2*pi; %Conversion to Radians
            
            %This If-Statement determines the Amplitude of the Red Ball
            if psifinal <= pi/4;
                redamp = 10*sin(psifinal);
            elseif psifinal > pi/4;
                redamp = 10*cos(psifinal);
            end
            
            blueamp1 = 10*sin(psi); %Amplitude of first Blue Ball
            blueamp2 = 10*cos(psi); %Amplitude of second Blue Ball
            
            %This section presets a movement vector for the "ball" and creates the ball
            a = 0.5; b = 0.5; %Major and Minor axis widths
            r = linspace(0, 2*pi, 1000);
            width = a*cos(r);
            height = b*sin(r);
            
            xcenter = 0;
            ycenter = 0;
            
            %Drawing the Balls
            redball = patch(xcenter+width, ycenter+height, 'r', 'parent', handles.axes1); 
            blueball1 = patch(xcenter+width, ycenter+height, 'b', 'parent', handles.axes1);
            blueball2 = patch(xcenter+width, ycenter+height, 'b', 'parent', handles.axes1);
            
            rtheta = linspace(0, 2*pi, 100); %thetavector for red
            b1thetax = linspace(0, 2*pi, 100); %thetavector for blue 1 x
            b1thetay = linspace(pi, 3*pi, 100); %thetavector for blue 1 y
            b2theta = linspace(0, 2*pi, 100);
            
            handles.B.mobilexaxis = mobilexaxis;
            handles.B.mobileyaxis = mobileyaxis;
            handles.B.analyzer = analyzer;
            handles.B.sample = sample;
            handles.B.polarizer = polarizer;
            guidata(hObject, handles);
            
        end
        
        %This While Loop only continues as long as the Analyzer Button is pressed
        %down
        while get(handles.BPanimate, 'value') == 1;
            
            for k = 1:length(rtheta);
                delete(redball); delete(blueball1); delete(blueball2);
                redball = patch(10*sin(rtheta(k))+width, height, 'r', 'parent', handles.axes1);
                blueball1 = patch(blueamp1*sin(psi)*sin(b1thetax(k))+width, blueamp1*cos(psi)*sin(b1thetay(k))+height, 'b', 'parent', handles.axes1);
                blueball2 = patch(blueamp2*cos(psi)*sin(b2theta(k))+width, blueamp2*sin(psi)*sin(b2theta(k))+height, 'b', 'parent', handles.axes1);
                
                pause(0.01); 
            end
            
        end
        
    case 'pausebutton'
        
end


function psiedit_Callback(hObject, eventdata, handles)
%This function activates when a new value is entered for Psi, and no
%Animations are presently active

if get(handles.BAanimate, 'value') == 0 & get(handles.BSanimate, 'value') == 0 & get(handles.BPanimate, 'value') == 0;
    struct2var(handles.B);
    struct2var(handles.font);
    psi = str2double(get(handles.psiedit, 'string'))/360*2*pi;
    dphi = str2double(get(handles.dpedit, 'string'))/360*2*pi;
    
    cla(handles.axes1);
    axis(handles.axes1, [-10 10 -10 10]);
    hold(handles.axes1, 'on');

    staticxaxis = plot(handles.axes1, [-10 10], [0 0], 'k', 'linewidth', 2);
    staticyaxis = plot(handles.axes1, [0 0], [-10 10], 'k', 'linewidth', 2);

    mobilexaxis = plot(handles.axes1, [-10*sin(psi) 10*sin(psi)], [10*cos(psi) -10*cos(psi)], 'k');
    mobileyaxis = plot(handles.axes1, [-10*cos(psi) 10*cos(psi)], [-10*sin(psi) 10*sin(psi)], 'k');

    handles.B.mobilexaxis = mobilexaxis;
    handles.B.mobileyaxis = mobileyaxis;
    handles.B.analyzer = analyzer;
    handles.B.sample = sample;
    handles.B.polarizer = polarizer;
    
    guidata(hObject, handles);
    
end


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

% --- Executes on button press in adetail.
function adetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Analyzer Birefringence');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

Adetail = figure('position', [100, 100, 400, 500], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Analyzer');
Adetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(Adetailtext, 'string', stringtext);
set(Adetailtext, 'position', [25 50 350 400], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in sdetail.
function sdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Sample Birefringence');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

Sdetail = figure('position', [100, 100, 400, 500], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Sample');
Sdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(Sdetailtext, 'string', stringtext);
set(Sdetailtext, 'position', [25 50 350 400], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in pdetail.
function pdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Polarizer Birefringence');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

Pdetail = figure('position', [100, 100, 400, 500], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Polarizer');
Pdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(Pdetailtext, 'string', stringtext);
set(Pdetailtext, 'position', [25 50 350 400], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');


% --- Executes on button press in birefringencedetail.
function birefringencedetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Birefringence');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

Bdetail = figure('position', [100, 100, 400, 500], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Birefringence');
Bdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(Bdetailtext, 'string', stringtext);
set(Bdetailtext, 'position', [25 50 350 400], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
