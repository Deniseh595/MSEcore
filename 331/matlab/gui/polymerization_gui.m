function varargout = polymerization_gui(varargin)
% POLYMERIZATION_GUI MATLAB code for polymerization_gui.fig
%      POLYMERIZATION_GUI, by itself, creates a new POLYMERIZATION_GUI or raises the existing
%      singleton*.
%
%      H = POLYMERIZATION_GUI returns the handle to a new POLYMERIZATION_GUI or the handle to
%      the existing singleton*.
%
%      POLYMERIZATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POLYMERIZATION_GUI.M with the given input arguments.
%
%      POLYMERIZATION_GUI('Property','Value',...) creates a new POLYMERIZATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before polymerization_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to polymerization_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help polymerization_gui

% Last Modified by GUIDE v2.5 14-Jan-2014 10:11:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @polymerization_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @polymerization_gui_OutputFcn, ...
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


% --- Executes just before polymerization_gui is made visible.
function polymerization_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to polymerization_gui (see VARARGIN)

% Choose default command line output for polymerization_gui

fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');
fontsizeD = getappdata(0, 'fontsizeD');

handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;
handles.font.fontsizeD = fontsizeD;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes polymerization_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = polymerization_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%This section is for Step Growth Polymerization Animation
%--------------------------------------------------------
function stepgrowthbutton_Callback(hObject, eventdata, handles)
cla(handles.axes1);
reset(handles.axes1);
set(handles.stepanimation, 'Visible', 'on'); %allows for animation
set(handles.chainanimate, 'visible', 'off'); %prevents clicking of others
set(handles.statisticalanimate, 'visible', 'off');
set(handles.nonlinearanimate, 'visible', 'off');
set(handles.DPanimate, 'visible', 'off');
set(handles.Panimate, 'Visible', 'off');

xlim([0, 25]);
ylim([0,25]);
axis square;

xcenter = [1, 4, 7, 12, 16, 19, 22, 2, 5, 7, 14, 17, 21, 23, 2, 4.5, 8, 11.5, 15, 19, 22.5, 1.5, 5, 8.5, 14, 17, 20, 23, 2, 5, 7.5, 11.5, 15, 19.75, 22, 1, 3.5, 7, 10.5, 14.75, 18, 21, 1.5, 4, 9, 13, 16, 21, 23.5];
ycenter = [2, 3, 1, 5, 2, 4, 3, 5, 7, 4, 7, 6, 7, 5.5, 10, 9, 8.5, 9, 9.5, 10.5, 8, 12.5, 13.5, 11, 14, 13, 12.5, 11, 16, 15.5, 15.75, 16.5, 15.5, 15.5, 16, 19, 21, 20, 20.5, 19.75, 21, 19, 23.5, 23, 23.25, 22, 24, 23, 24];

r = 0.75;
N = 1000;
color = ['g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g'] ;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

hold on
for k = 1:length(xcenter);
    
Xnew=X+xcenter(k);
Ynew=Y+ycenter(k);
h=fill(Xnew,Ynew,color(k));
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in stepanimation.
function stepanimation_Callback(hObject, eventdata, handles)

set(handles.stepanimation, 'Visible', 'off'); %prevents re-clicking

%Second Polymerization Image
pause(1);
cla(handles.axes1);

xlim([0, 25]);
ylim([0,25]);
axis square;

xcenter = [1 2.15 3.5 12 16 17 22 7 14 17 18 23 2 2.25 3.45 4.5 5.7 11.5 13 22.5 1.5 2 3.2 5 6.45 14 17 18 19.25 23 7.5 9.05 15 16.5 22 1 2.25 10.5 14.75 18 19.15 1.5 4 5.2 9 10.45 16 17.45 18.9];
ycenter = [2 3 2.25 5.00 2 3.2 3 4 7 6 7.18 5.5 10 8.5 7.6 9 8.05 9 9.25 8.0 12.5 14 15 13.5 13 14 13 11.85 11 11 15.75 16 15.5 15.5 16 19 20 20.5 19.75 21 20 23.5 23 22 23.25 23 24 23.5 24];

r = 0.75;
N = 1000;
color = ['g', 'r', 'g', 'g', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r'] ;

theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

hold on
for k = 1:length(xcenter);
    
Xnew=X+xcenter(k);
Ynew=Y+ycenter(k);
h=fill(Xnew,Ynew,color(k));
end

% Third Polymerization Image
pause(1);
cla(handles.axes1);

xcenter = [1 2.3 3.5 4.75 17 18 16 15 2 2.25 3.45 4.5 5.7 11.5 13 14 13.5 1.5 2 3.2 4.6 6.05 7 8.55 15 16.5 16.5 17.5 18.5 19.75 22 23 22.5 23.5 23 1 2.25 2 3.15 4.35 9 10.45 10.5 16 17.45 18.9 19.5 20.65];
ycenter = [2 1.3 2.25 3.15 6 7.18 4.9 3.7 10 8.5 7.6 8.7 7.75 9 9.25 8.1 6.6 12.5 14 15 14.5 14 15.2 15.45 15.5 15.5 14 13 11.85 11 16 14.9 13.5 12.4 11 19 20 21.5 22.5 21.5 23.25 23 21.5 24 23.5 24 22.6 21.6];

theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
color = ['g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r'] ;

hold on
for k = 1:length(xcenter);
    
Xnew=X+xcenter(k);
Ynew=Y+ycenter(k);
h=fill(Xnew,Ynew,color(k));
end

% Fourth Polymerization Image
pause(1);
cla(handles.axes1);
xcenter = [2 2.25 3.45 4.5 5.7 2 2.5 3.7 5.1 6.55 7.5 9.05 6.5 5.25 4.05 2.75 9 10.45 10.5 8.35 7.15 6 6.25 5 16 17.45 18.9 19.5 20.65 22 23 22.5 23.5 23 15 16.5 16.5 17.5 18.5 19.75 21.2 22.7 23.7 23.2 21.75 20.75 19.75 18.75];
ycenter = [10 8.5 7.6 8.7 7.75 11.5 13 14 13.5 13 14.2 14.45 6.5 5.6 4.65 5.35 23.25 23 21.5 21.9 22.9 21.9 20.4 19.4 24 23.5 24 22.6 21.6 21 19.9 18.5 17.4 16 15.5 15.5 14 13 11.85 11 11 11.25 10.1 8.6 8 6.82 5.72 4.52];

theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
color = ['g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g', 'r', 'g'] ;

hold on
for k = 1:length(xcenter);
    
Xnew=X+xcenter(k);
Ynew=Y+ycenter(k);
h=fill(Xnew,Ynew,color(k));
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%--------------This Section is for the Chain Growth Animation----------
%----------------------------------------------------------------------
function chaingrowthbutton_Callback(hObject, eventdata, handles)
cla(handles.axes1);
set(handles.chainanimate, 'Visible', 'on'); %allows animation
set(handles.stepanimation, 'Visible', 'off'); %prevents re-clicking of others
set(handles.statisticalanimate, 'visible', 'off');
set(handles.nonlinearanimate, 'visible', 'off');
set(handles.DPanimate, 'visible', 'off');
set(handles.Panimate, 'Visible', 'off');

xlim([0, 25]); ylim([0,25]);
axis square;
r = 0.75;
N = 1000;
color1 = 'r';
color2 = 'g';
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

xcenter = [1 4 6 12 13 20 2 9 15 18 23 2 7 10 15 19 24 3 7 16 21 4 10 15];
ycenter = [2 7 4 4  11 2 10 9 7 12  8 15 13 16 14 15 14 19 20 18 20 23 22 23];

hold on
h = zeros(1, length(xcenter));
for k = 1:length(xcenter); 
        Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
        h(k)=fill(Xnew,Ynew,color1);
end

xgreen = [20 9 21 3];
ygreen = [2 9 20 19];

q = zeros(1, length(xgreen));
for k = 1: length(xgreen);
    Xoutline = X+xgreen(k); Youtline = Y+ygreen(k);
    q(k) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);
end

handles.chain.q = q;
handles.chain.h = h;
handles.chain.X = X; handles.chain.Y = Y;
handles.chain.xcenter = xcenter; handles.chain.ycenter = ycenter;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in chainanimate.
function chainanimate_Callback(hObject, eventdata, handles)
struct2var(handles.chain);
set(handles.chainanimate, 'visible', 'off');
color1 = 'r'; color2 = 'g';

%q1 movement 1
xvector = linspace(xcenter(11), 21, 15);
yvector = linspace(ycenter(11), 3.2, 15);

for k = 1:length(xvector);
    delete(h(11));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(11)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+21; Youtline = Y+3.2;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 1
xvector = linspace(xcenter(14), 20.5, 15);
yvector = linspace(ycenter(14), 18.6, 15);

for k = 1:length(xvector);
    delete(h(14));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(14)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+20.5; Youtline = Y+18.6;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 2
xvector = linspace(xcenter(17), 20, 15);
yvector = linspace(ycenter(17), 17.2, 15);

for k = 1:length(xvector);
    delete(h(17));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(17)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+20; Youtline = Y+17.2;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 1
xvector = linspace(xcenter(7), 7.6, 15);
yvector = linspace(ycenter(7), 8.4, 15);

for k = 1:length(xvector);
    delete(h(7));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(7)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7.6; Youtline = Y+8.4;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 2
xvector = linspace(xcenter(10), 20.2, 20);
yvector = linspace(ycenter(10), 4.5, 20);

for k = 1:length(xvector);
    delete(h(10));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(10)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+20.2; Youtline = Y+4.5;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 1
xvector = linspace(xcenter(19), 4, 15);
yvector = linspace(ycenter(19), 20.2, 15);

for k = 1:length(xvector);
    delete(h(19));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(19)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+4; Youtline = Y+20.2;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);


%q3 movement 3
xvector = linspace(xcenter(24), 19, 15);
yvector = linspace(ycenter(24), 16, 15);

for k = 1:length(xvector);
    delete(h(24));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(24)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+19; Youtline = Y+16;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 2
xvector = linspace(xcenter(2), 7.2, 15);
yvector = linspace(ycenter(2), 7, 15);

for k = 1:length(xvector);
    delete(h(2));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(2)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7.2; Youtline = Y+7;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 2
xvector = linspace(xcenter(22), 4.5, 15);
yvector = linspace(ycenter(22), 21.6, 15);

for k = 1:length(xvector);
    delete(h(22));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(22)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+4.5; Youtline = Y+21.6;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 3
xvector = linspace(xcenter(3), 7, 15);
yvector = linspace(ycenter(3), 5.5, 15);

for k = 1:length(xvector);
    delete(h(3));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(3)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7; Youtline = Y+5.5;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 3
xvector = linspace(xcenter(9), 19, 15);
yvector = linspace(ycenter(9), 5.4, 15);

for k = 1:length(xvector);
    delete(h(9));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(9)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+19; Youtline = Y+5.4;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 3
xvector = linspace(xcenter(23), 5.8, 15);
yvector = linspace(ycenter(23), 22.1, 15);

for k = 1:length(xvector);
    delete(h(23));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(23)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+5.8; Youtline = Y+22.1;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 4
xvector = 19;
yvector = linspace(ycenter(16), 6.9, 20);

for k = 1:length(yvector);
    delete(h(16));
    Xnew=X+xvector; Ynew=Y+yvector(k);
    h(16)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+19; Youtline = Y+6.9;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 4
xvector = linspace(xcenter(12), 17.6, 15);
yvector = linspace(ycenter(12), 16.4, 15);

for k = 1:length(xvector);
    delete(h(12));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(12)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+17.6; Youtline = Y+16.4;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 4
xvector = linspace(xcenter(1), 6.7, 15);
yvector = linspace(ycenter(1), 4, 15);

for k = 1:length(xvector);
    delete(h(1));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(1)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+6.7; Youtline = Y+4;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 4
xvector = linspace(xcenter(20), 6.8, 15);
yvector = linspace(ycenter(20), 21, 15);

for k = 1:length(xvector);
    delete(h(20));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(20)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+6.8; Youtline = Y+21;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 5
xvector = linspace(xcenter(4), 8, 15);
yvector = linspace(ycenter(4), 3.2, 15);

for k = 1:length(xvector);
    delete(h(4));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(4)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+8; Youtline = Y+3.2;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 5
xvector = linspace(xcenter(5), 16.5, 15);
yvector = linspace(ycenter(5), 17.3, 15);

for k = 1:length(xvector);
    delete(h(5));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(5)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+16.5; Youtline = Y+17.3;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 6
xvector = linspace(xcenter(13), 15, 15);
yvector = linspace(ycenter(13), 17.3, 15);

for k = 1:length(xvector);
    delete(h(13));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(13)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+15; Youtline = Y+17.3;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);


%q4 movement 5
xvector = linspace(xcenter(15), 7.9, 15);
yvector = linspace(ycenter(15), 20, 15);

for k = 1:length(xvector);
    delete(h(15));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(15)=fill(Xnew,Ynew,color1);
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+7.9; Youtline = Y+20;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%---------------------This Section is for Statistical Copolymerization--
%-----------------------------------------------------------------------
function statisticalbutton_Callback(hObject, eventdata, handles)

cla(handles.axes1);
set(handles.statisticalanimate, 'Visible', 'on'); %allows for animation
set(handles.stepanimation, 'Visible', 'off'); %prevents re-clicking of others
set(handles.chainanimate, 'visible', 'off');
set(handles.nonlinearanimate, 'visible', 'off');
set(handles.DPanimate, 'visible', 'off');
set(handles.Panimate, 'Visible', 'off');

xlim([0, 25]); ylim([0,25]);
axis square;
r = 0.75;
N = 1000;
color1 = ['r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b'];
color2 = 'g';
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

xcenter = [1 4 6 12 13 20 2 9 15 18 23 2 7 10 15 19 24 3 7 16 21 4 10 15];
ycenter = [2 7 4 4  11 2 10 9 7 12  8 15 13 16 14 15 14 19 20 18 20 23 22 23];

hold on
h = zeros(1, length(xcenter));
for k = 1:length(xcenter); 
        Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
        h(k)=fill(Xnew,Ynew,color1(k));
end

xgreen = [20 9 21 3];
ygreen = [2 9 20 19];

q = zeros(1, length(xgreen));
for k = 1: length(xgreen);
    Xoutline = X+xgreen(k); Youtline = Y+ygreen(k);
    q(k) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);
end

handles.statistical.q = q;
handles.statistical.h = h;
handles.statistical.X = X; handles.statistical.Y = Y;
handles.statistical.xcenter = xcenter; handles.statistical.ycenter = ycenter;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in statisticalanimate.
function statisticalanimate_Callback(hObject, eventdata, handles)

set(handles.statisticalanimate, 'Visible', 'off'); %prevents reclicking
struct2var(handles.statistical);
color1 = ['r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b']; 
color2 = 'g';

%q1 movement 1
xvector = linspace(xcenter(11), 21, 15);
yvector = linspace(ycenter(11), 3.2, 15);

for k = 1:length(xvector);
    delete(h(11));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(11)=fill(Xnew,Ynew,color1(11));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+21; Youtline = Y+3.2;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 1
xvector = linspace(xcenter(14), 20.5, 15);
yvector = linspace(ycenter(14), 18.6, 15);

for k = 1:length(xvector);
    delete(h(14));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(14)=fill(Xnew,Ynew,color1(14));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+20.5; Youtline = Y+18.6;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 2
xvector = linspace(xcenter(17), 20, 15);
yvector = linspace(ycenter(17), 17.2, 15);

for k = 1:length(xvector);
    delete(h(17));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(17)=fill(Xnew,Ynew,color1(17));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+20; Youtline = Y+17.2;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 1
xvector = linspace(xcenter(7), 7.6, 15);
yvector = linspace(ycenter(7), 8.4, 15);

for k = 1:length(xvector);
    delete(h(7));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(7)=fill(Xnew,Ynew,color1(7));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7.6; Youtline = Y+8.4;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 2
xvector = linspace(xcenter(10), 20.2, 20);
yvector = linspace(ycenter(10), 4.5, 20);

for k = 1:length(xvector);
    delete(h(10));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(10)=fill(Xnew,Ynew,color1(10));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+20.2; Youtline = Y+4.5;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 1
xvector = linspace(xcenter(19), 4, 15);
yvector = linspace(ycenter(19), 20.2, 15);

for k = 1:length(xvector);
    delete(h(19));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(19)=fill(Xnew,Ynew,color1(19));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+4; Youtline = Y+20.2;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);


%q3 movement 3
xvector = linspace(xcenter(24), 19, 15);
yvector = linspace(ycenter(24), 16, 15);

for k = 1:length(xvector);
    delete(h(24));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(24)=fill(Xnew,Ynew,color1(24));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+19; Youtline = Y+16;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 2
xvector = linspace(xcenter(2), 7.2, 15);
yvector = linspace(ycenter(2), 7, 15);

for k = 1:length(xvector);
    delete(h(2));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(2)=fill(Xnew,Ynew,color1(2));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7.2; Youtline = Y+7;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 2
xvector = linspace(xcenter(22), 4.5, 15);
yvector = linspace(ycenter(22), 21.6, 15);

for k = 1:length(xvector);
    delete(h(22));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(22)=fill(Xnew,Ynew,color1(22));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+4.5; Youtline = Y+21.6;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 3
xvector = linspace(xcenter(3), 7, 15);
yvector = linspace(ycenter(3), 5.5, 15);

for k = 1:length(xvector);
    delete(h(3));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(3)=fill(Xnew,Ynew,color1(3));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+7; Youtline = Y+5.5;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 3
xvector = linspace(xcenter(9), 19, 15);
yvector = linspace(ycenter(9), 5.4, 15);

for k = 1:length(xvector);
    delete(h(9));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(9)=fill(Xnew,Ynew,color1(9));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+19; Youtline = Y+5.4;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 3
xvector = linspace(xcenter(23), 5.8, 15);
yvector = linspace(ycenter(23), 22.1, 15);

for k = 1:length(xvector);
    delete(h(23));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(23)=fill(Xnew,Ynew,color1(23));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+5.8; Youtline = Y+22.1;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q1 movement 4
xvector = 19;
yvector = linspace(ycenter(16), 6.9, 20);

for k = 1:length(yvector);
    delete(h(16));
    Xnew=X+xvector; Ynew=Y+yvector(k);
    h(16)=fill(Xnew,Ynew,color1(16));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(1));
Xoutline = X+19; Youtline = Y+6.9;
q(1) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 4
xvector = linspace(xcenter(12), 17.6, 15);
yvector = linspace(ycenter(12), 16.4, 15);

for k = 1:length(xvector);
    delete(h(12));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(12)=fill(Xnew,Ynew,color1(12));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+17.6; Youtline = Y+16.4;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 4
xvector = linspace(xcenter(1), 6.7, 15);
yvector = linspace(ycenter(1), 4, 15);

for k = 1:length(xvector);
    delete(h(1));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(1)=fill(Xnew,Ynew,color1(1));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+6.7; Youtline = Y+4;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q4 movement 4
xvector = linspace(xcenter(20), 6.8, 15);
yvector = linspace(ycenter(20), 21, 15);

for k = 1:length(xvector);
    delete(h(20));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(20)=fill(Xnew,Ynew,color1(20));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+6.8; Youtline = Y+21;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q2 movement 5
xvector = linspace(xcenter(4), 8, 15);
yvector = linspace(ycenter(4), 3.2, 15);

for k = 1:length(xvector);
    delete(h(4));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(4)=fill(Xnew,Ynew,color1(4));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(2));
Xoutline = X+8; Youtline = Y+3.2;
q(2) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 5
xvector = linspace(xcenter(5), 16.5, 15);
yvector = linspace(ycenter(5), 17.3, 15);

for k = 1:length(xvector);
    delete(h(5));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(5)=fill(Xnew,Ynew,color1(5));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+16.5; Youtline = Y+17.3;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

%q3 movement 6
xvector = linspace(xcenter(13), 15, 15);
yvector = linspace(ycenter(13), 17.3, 15);

for k = 1:length(xvector);
    delete(h(13));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(13)=fill(Xnew,Ynew,color1(13));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(3));
Xoutline = X+15; Youtline = Y+17.3;
q(3) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);


%q4 movement 5
xvector = linspace(xcenter(15), 7.9, 15);
yvector = linspace(ycenter(15), 20, 15);

for k = 1:length(xvector);
    delete(h(15));
    Xnew=X+xvector(k); Ynew=Y+yvector(k);
    h(15)=fill(Xnew,Ynew,color1(15));
    
    xlim([0, 25]); ylim([0,25]);
    axis square;
    pause(0.02)
end

delete(q(4));
Xoutline = X+7.9; Youtline = Y+20;
q(4) = plot(Xoutline, Youtline, color2, 'LineWidth', 1.1);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%--------------------This Section is for Nonlinear Polymerization---
%-------------------------------------------------------------------

function nonlinearbutton_Callback(hObject, eventdata, handles)

function nonlinearanimate_Callback(hObject, eventdata, handles)

%---------------This Section is for Detailed Polymer Formation---
%----------------------------------------------------------------

function DPbutton_Callback(hObject, eventdata, handles)

cla(handles.axes1);
set(handles.DPanimate, 'Visible', 'on');
set(handles.stepanimation, 'Visible', 'off'); %prevents re-clicking of others
set(handles.chainanimate, 'visible', 'off');
set(handles.statisticalanimate, 'visible', 'off');
set(handles.nonlinearanimate, 'visible', 'off');
set(handles.Panimate, 'Visible', 'off');
struct2var(handles.font);

reset(handles.axes1);
xlim(handles.axes1, [0 20]);
ylim(handles.axes1, [0 15]);

H1 = text(4, 7, 'H', 'fontsize', fontsizeD);
C1 = text(4, 6, 'C', 'fontsize', fontsizeD);
R1 = text(4, 5, 'R', 'fontsize', fontsizeD);

H2 = text(14, 7, 'H', 'fontsize', fontsizeD);
C2 = text(14, 6, 'C', 'fontsize', fontsizeD);
H3 = text(14, 5, 'H', 'fontsize', fontsizeD);

H4 = text(15.5, 7, 'H', 'fontsize', fontsizeD);
C3 = text(15.5, 6, 'C', 'fontsize', fontsizeD);
R2 = text(15.5, 5, 'R', 'fontsize', fontsizeD);

r = 0.14;
N = 1000;

theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X1,Y1] = pol2cart(theta,rho);

hold on;

%Electron Vectors for each different situation
if get(handles.radicalradiobutton, 'value') == get(handles.radicalradiobutton, 'Max');
    
color = ['r', 'k', 'k', 'k', 'k'];
x1center = [4.8, 14.75, 15.25, 14.75, 15.25];
y1center = [6.2, 6.2, 6.2, 5.75, 5.75];

elseif get(handles.anionbutton, 'value') == get(handles.anionbutton, 'max');

anion = text(5, 6.5, '-', 'fontsize', fontsizeD, 'color', 'r');
color = ['r', 'r', 'k', 'k', 'k', 'k'];
x1center = [4.8, 4.8, 14.75, 15.25, 14.75, 15.25];
y1center = [6.2, 5.75, 6.2, 6.2, 5.75, 5.75];

handles.polymerization.anion = anion;

elseif get(handles.cationbutton, 'value') == get(handles.cationbutton, 'max');

cation = text(5, 6.5, '+', 'fontsize', fontsizeD, 'color', 'r');
color = ['k', 'k', 'k', 'k'];
x1center = [14.75, 15.25, 14.75, 15.25];
y1center = [6.2, 6.2, 5.75, 5.75];

handles.polymerization.cation = cation;

end

h = zeros(1, length(x1center));

%generating each set of polymer/electron circles
for k = 1:length(x1center);
    X1new=X1+x1center(k); Y1new=Y1+y1center(k);
    h(k)=fill(X1new,Y1new, color(k));
end

handles.polymerization.H1 = H1;
handles.polymerization.C1 = C1;
handles.polymerization.R1 = R1;
handles.polymerization.X1 = X1;
handles.polymerization.Y1 = Y1;
handles.polymerization.x1center = x1center;
handles.polymerization.y1center = y1center;
handles.polymerization.h = h;
        
guidata(hObject,handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in DPanimate.
function DPanimate_Callback(hObject, eventdata, handles)

struct2var(handles.polymerization);
struct2var(handles.font);
set(handles.DPanimate, 'Visible', 'off');

if get(handles.radicalradiobutton, 'value') == get(handles.radicalradiobutton, 'max');
    
    xvector = linspace(4, 13, 40);
    
    h1xvector = linspace(4.8, 13.8, 40);
    h2xvector = linspace(14.75, 13.8, 10);
    h3xvector = linspace(15.25, 16.25, 10);
    h2yvector = linspace(6.2, 5.75, 10);
    
    %Animating the Letters
    for k = 1: length(xvector);
        X1new = X1+h1xvector(k); Y1new = Y1+y1center(1);
        
        delete(H1); delete(C1); delete(R1); delete(h(1));
        
        H1 = text(xvector(k), 7, 'H', 'fontsize', fontsizeD);
        C1 = text(xvector(k), 6, 'C', 'fontsize', fontsizeD);
        R1 = text(xvector(k), 5, 'R', 'fontsize', fontsizeD);
        h(1) = fill(X1new, Y1new, 'r');
        
        pause(0.02);
        
    end
    
    %Animating the other Electrons
    for k = 1:length(h2xvector);
        X2new = X1+h2xvector(k); Y2new = Y1+h2yvector(k);
        delete(h(2));
        h(2) = fill(X2new, Y2new, 'k');
        pause(0.02);
    end
    
    h(1) = fill(X1new, Y1new, 'k');
    
    for k = 1:length(h3xvector);
        X3new = X1+h3xvector(k); Y3new = Y1+y1center(3);
        delete(h(3));
        h(3) = fill(X3new, Y3new, 'k');
        pause(0.02);
    end
    
    h(3) = fill(X3new, Y3new, 'r');
    
elseif get(handles.anionbutton, 'value') == get(handles.anionbutton, 'max');
    
    xvector = linspace(4, 13, 40);
    anionvector = linspace(5, 14, 40);
    anionvector2 = linspace(14, 16.75, 15);

    h1xvector = linspace(4.8, 13.8, 40);
    h2xvector = linspace(4.8, 13.8, 40);
    h3xvector = linspace(14.75, 16.25, 10);
    h4xvector = linspace(15.25, 16.25, 10);
    h4yvector = linspace(6.2, 5.75, 10);
    
    %Animating the Letters
    for k = 1: length(xvector);
        X1new = X1+h1xvector(k); Y1new = Y1+y1center(1);
        X2new = X1+h2xvector(k); Y2new = Y1+y1center(2);
        
        delete(H1); delete(C1); delete(R1); delete(h(1)); delete(h(2));
        delete(anion);
        
        H1 = text(xvector(k), 7, 'H', 'fontsize', fontsizeD);
        C1 = text(xvector(k), 6, 'C', 'fontsize', fontsizeD);
        R1 = text(xvector(k), 5, 'R', 'fontsize', fontsizeD);
        h(1) = fill(X1new, Y1new, 'r');
        h(2) = fill(X1new, Y2new, 'r');
        anion = text(anionvector(k), 6.5, '-', 'fontsize', fontsizeD, 'color', 'r');
        
        pause(0.02);
    end
    
    h(1) = fill(X1new, Y1new, 'k');
    h(2) = fill(X2new, Y2new, 'k');
    
    %Animating the Anion
    for k = 1:length(anionvector2);
        
        delete(anion);
        anion = text(anionvector2(k), 6.5, '-', 'fontsize', fontsizeD, 'color', 'r');
        pause(0.02);
    end
    
    %Animating the other Electrons
    for k = 1:length(h3xvector);
        X3new = X1+h3xvector(k); Y3new = Y1+y1center(3);
        delete(h(3));
        h(3) = fill(X3new, Y3new, 'k');
        pause(0.02);
    end
    
    h(3) = fill(X3new, Y3new, 'r');
    
    for k = 1:length(h4xvector);
        X4new = X1+h4xvector(k); Y4new = Y1+h4yvector(k);
        delete(h(4));
        h(4) = fill(X4new, Y4new, 'k');
        pause(0.02);
    end
    
    h(4) = fill(X4new, Y4new, 'r');
    
elseif get(handles.cationbutton, 'value') == get(handles.cationbutton, 'max');

    xvector = linspace(4, 13, 40);
    cationvector = linspace(5, 14, 40);
    cationvector2 = linspace(14, 16.75, 15);

    h1xvector = linspace(14.75, 13.8, 10);
    h2xvector = linspace(15.25, 13.8, 10);
    h2yvector = linspace(6.2, 5.75, 10);
    
    %Animating the Letters
    for k = 1: length(xvector);
        
        delete(H1); delete(C1); delete(R1);
        delete(cation);
        
        H1 = text(xvector(k), 7, 'H', 'fontsize', fontsizeD);
        C1 = text(xvector(k), 6, 'C', 'fontsize', fontsizeD);
        R1 = text(xvector(k), 5, 'R', 'fontsize', fontsizeD);
        cation = text(cationvector(k), 6.5, '+', 'fontsize', fontsizeD, 'color', 'r');
        
        pause(0.02);
    end
    
    %Animating the Cation's Additional Movement
    for k = 1: length(cationvector2);
        delete(cation);
        cation = text(cationvector2(k), 6.5, '+', 'fontsize', fontsizeD, 'color', 'r');
        pause(0.02);
    end
    
    %Animating the other Electrons
    for k = 1:length(h1xvector);
        X1new = X1+h1xvector(k); Y1new = Y1+y1center(1);
        delete(h(1));
        h(1) = fill(X1new, Y1new, 'k');
        pause(0.02);
    end
    
    h(1) = fill(X1new, Y1new, 'k');
    
    for k = 1:length(h2xvector);
        X2new = X1+h2xvector(k); Y2new = Y1+h2yvector(k);
        delete(h(2));
        h(2) = fill(X2new, Y2new, 'k');
        pause(0.02);
    end
    
    h(2) = fill(X2new, Y2new, 'k');
    
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- This Section is for Polyisoprene Polymerization Animations---
% -----------------------------------------------------------------
function Pbutton_Callback(hObject, eventdata, handles)

cla(handles.axes1);
set(handles.DPanimate, 'Visible', 'off');
set(handles.stepanimation, 'Visible', 'off'); %prevents re-clicking of others
set(handles.chainanimate, 'visible', 'off');
set(handles.statisticalanimate, 'visible', 'off');
set(handles.nonlinearanimate, 'visible', 'off');
set(handles.Panimate, 'Visible', 'on');

struct2var(handles.font);

reset(handles.axes1);

prereaction = imread('./Pictures/Polyisoprene.jpg');
imshow(prereaction);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in Panimate.
function Panimate_Callback(hObject, eventdata, handles)

cla(handles.axes1);
reset(handles.axes1);

if get(handles.addition12, 'value') == 1;
    reaction = imread('./Pictures/Polyisoprene 1-2.jpg');
    imshow(reaction);
    
% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

elseif get(handles.addition34, 'value') == 1;
    reaction = imread('./Pictures/Polyisoprene 3-4.jpg');
    imshow(reaction);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

elseif get(handles.addition14c, 'value') == 1;
    reaction = imread('./Pictures/Polyisoprene 1-4 Cis.jpg');
    imshow(reaction);
    
% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

elseif get(handles.addition14t, 'value') == 1;
    reaction = imread('./Pictures/Polyisoprene 1-4 Trans.jpg');
    imshow(reaction);
    
% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

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


% --- Executes on button press in SCdetail.
function SCdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Statistical Copolymerization');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

SCdetailfig = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Step Growth Polymerization');
SCdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(SCdetailtext, 'string', stringtext);
set(SCdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in NLdetail.
function NLdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Nonlinear Step Growth Polymerization');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

NLdetailfig = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Non-Linear Step Growth Polymerization');
NLdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(NLdetailtext, 'string', stringtext);
set(NLdetailtext, 'position', [25 50 350 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in CGdetail.
function CGdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Chain Growth Polymerization');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

CGdetailfig = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Chain Growth Polymerization');
CGdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(CGdetailtext, 'string', stringtext);
set(CGdetailtext, 'position', [25 50 350 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in DPdetail.
function DPdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Reactive Species of Chain Growth Polymerization');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

DPdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Polymerization Mechanisms');
DPdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(DPdetailtext, 'string', stringtext);
set(DPdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
