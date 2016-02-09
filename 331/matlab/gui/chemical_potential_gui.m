function varargout = chemical_potential_gui(varargin)
% CHEMICAL_POTENTIAL_GUI MATLAB code for chemical_potential_gui.fig
%      CHEMICAL_POTENTIAL_GUI, by itself, creates a new CHEMICAL_POTENTIAL_GUI or raises the existing
%      singleton*.
%
%      H = CHEMICAL_POTENTIAL_GUI returns the handle to a new CHEMICAL_POTENTIAL_GUI or the handle to
%      the existing singleton*.
%
%      CHEMICAL_POTENTIAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHEMICAL_POTENTIAL_GUI.M with the given input arguments.
%
%      CHEMICAL_POTENTIAL_GUI('Property','Value',...) creates a new CHEMICAL_POTENTIAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chemical_potential_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chemical_potential_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chemical_potential_gui

% Last Modified by GUIDE v2.5 21-Nov-2013 12:13:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chemical_potential_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @chemical_potential_gui_OutputFcn, ...
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


% --- Executes just before chemical_potential_gui is made visible.
function chemical_potential_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chemical_potential_gui (see VARARGIN)

% Choose default command line output for chemical_potential_gui
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

% UIWAIT makes chemical_potential_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chemical_potential_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%------This Section is for the Chemical Potentials Animation----
%---------------------------------------------------------------
function CPstart_Callback(hObject, eventdata, handles)

set(handles.CPanimate, 'visible', 'on');
set(handles.ECPanimate, 'visible', 'off');
set(handles.EManimate, 'visible', 'off');
set(handles.IEManimate, 'visible', 'off');
set(handles.MSanimate, 'visible', 'off');
set(handles.entropytext, 'string', ' ');
struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 25 0 25]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');

poolx = [5 5 20 20];
pooly = [2 12 12 2];

pool = fill(poolx, pooly, 'c');

left = plot(5, 2:0.05:15, 'k');
right = plot(20, 2:0.05:15, 'k');
bottom = plot(5:0.05:20, 2, 'k');
surface = plot(5:0.4:20, 12, '--k', 'linewidth', 2);

moleculetext = text(1, 22, 'A Molecule', 'fontsize', fontsizeD);
energytext = text(13, 23, 'Free Energy of Mixture', 'fontsize', fontsizeD);
formulatext = text(18, 21, 'F_{0}', 'fontsize', fontsizeD);

line = plot(linspace(4.5, 5.5, 100), linspace(21, 20.75, 100), 'k');

%Generating Polymer Molecule
r = 0.35;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

%left polymer circles
x1center = [4.2 4.5 5 5.6 6.3 6.75 7.3 8];
y1center = [20 19.35 18.9 18.6 18.6 19.1 19.5 19.4];

h = zeros(1, length(x1center));
%generating each set of polymer circles
for k = 1:length(x1center);
    X1new=X+x1center(k); Y1new=Y+y1center(k);
    h(k)=fill(X1new,Y1new,'r');
end

handles.CP.h = h;
handles.CP.X = X; handles.CP.Y = Y;
handles.CP.x1center = x1center;
handles.CP.y1center = y1center;
handles.CP.formulatext = formulatext;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in CPanimate.
function CPanimate_Callback(hObject, eventdata, handles)

struct2var(handles.CP);
struct2var(handles.font);

set(handles.CPanimate, 'visible', 'off');

%Creating Animation Vectors for the Polymer

xvector = zeros(30, 8);
yvector = zeros(30, 8);

for k = 1:8;
    xvector(1:30, k) = linspace(x1center(k), x1center(k)+5, 30);
    yvector(1:30, k) = linspace(y1center(k), y1center(k)-10, 30);
end

%Moving the Polymer

for m = 1:30;
    
    for k = 1:8;
        delete(h(k));
        
        Xnew = X+xvector(m, k);
        Ynew = Y+yvector(m, k);
        
        h(k) = fill(Xnew, Ynew, 'r');
        
    end
    
    pause(0.02);
end

%Raising the "Water Level"
poolx = [5 5 20 20];
pooly = [2 13 13 2];

pool = fill(poolx, pooly, 'c');
surface = plot(5:0.4:20, 12, '--k', 'linewidth', 2);

%Replot the Graph since the rising water covers it
for k = 1:8
    
    Xnew = X+xvector(30, k);
    Ynew = Y+yvector(30, k);
    h(k) = fill(Xnew, Ynew, 'r');
end

%Changing the Formula
delete(formulatext);
formulatext = text(18, 21, 'F_{0}+u_{A}', 'fontsize', fontsizeD);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%------This Section is for Exchange Chemical Potentials------
%------------------------------------------------------------
function ECPstart_Callback(hObject, eventdata, handles)
set(handles.ECPanimate, 'visible', 'on');
set(handles.CPanimate, 'visible', 'off');
set(handles.EManimate, 'visible', 'off');
set(handles.IEManimate, 'visible', 'off');
set(handles.MSanimate, 'visible', 'off');
set(handles.entropytext, 'string', ' ');
struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 25 0 25]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');

poolx = [7 7 22 22];
pooly = [2 12 12 2];

pool = fill(poolx, pooly, 'c');

left = plot(7, 2:0.05:15, 'k');
right = plot(22, 2:0.05:15, 'k');
bottom = plot(7:0.05:22, 2, 'k');
surface = plot(7:0.4:22, 12, '--k', 'linewidth', 2);

textx1 = 1; texty1 = 7; %These need to be specified for the animation
textx2 = 2; texty2 = 20;

moleculetext1 = text(textx1, texty1, 'B Segment','fontsize', fontsizeD, 'color', 'b');
moleculetext2 = text(textx2, texty2, 'A Segment', 'fontsize', fontsizeD, 'color', 'r');
energytext = text(13, 23, 'Free Energy of Mixture', 'fontsize', fontsizeD);
formulatext = text(18, 21, 'F_{0}','fontsize', fontsizeD);

%Generating Polymer Molecule
r = 0.35;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

%left polymer circles
x1center = [10.2 10.5 11 11.6 12.3 12.75 13.3 14];
y1center = [20 19.35 18.9 18.6 18.6 19.1 19.5 19.4];
x2center = [9.2 9.8 10.4 10.7 11.35 12 12.6 13.1];
y2center = [7 7.3 7.1 6.5 6.2 6.4 6.5 6.9];

h = zeros(1, length(x1center));
%generating each set of polymer circles
for k = 1:length(x1center);
    X1new=X+x1center(k); Y1new=Y+y1center(k);
    X2new = X+x2center(k); Y2new = Y+y2center(k);
    h(k)=fill(X1new,Y1new,'r');
    r(k) = fill (X2new, Y2new, 'b');
end

handles.ECP.h = h; handles.ECP.r = r;
handles.ECP.X = X; handles.ECP.Y = Y;
handles.ECP.x1center = x1center; handles.ECP.y1center = y1center;
handles.ECP.x2center = x2center; handles.ECP.y2center = y2center;
handles.ECP.textx1 = textx1; handles.ECP.texty1 = texty1;
handles.ECP.textx2 = textx2; handles.ECP.texty2 = texty2;
handles.ECP.moleculetext1 = moleculetext1; handles.ECP.moleculetext2 = moleculetext2;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in ECPanimate.
function ECPanimate_Callback(hObject, eventdata, handles)

struct2var(handles.ECP);
struct2var(handles.font);

%Creating Animation Vectors for the Polymer and Text
x1vector = zeros(30, 8); y1vector = zeros(30, 8);
x2vector = zeros(30, 8); y2vector = zeros(30, 8);
textvector1 = zeros(30,1); textyvector1 = zeros(30,1);
textvector2 = zeros(30,1); textyvector2 = zeros(30,1);

for k = 1:8;
    x1vector(1:30, k) = linspace(x1center(k), x2center(k), 30);
    y1vector(1:30, k) = linspace(y1center(k), y2center(k), 30);
    
    x2vector(1:30, k) = linspace(x2center(k), x1center(k), 30);
    y2vector(1:30, k) = linspace(y2center(k), y1center(k), 30);        
        
end

textxvector1(1:30, 1) = linspace(textx1, textx2, 30);
textyvector1(1:30, 1) = linspace(texty1, texty2, 30);
textxvector2(1:30, 1) = linspace(textx2, textx1, 30);
textyvector2(1:30, 1) = linspace(texty2, texty1, 30);

%Moving the Polymer and Text

for m = 1:30;  
    for k = 1:8;
        delete(h(k)); delete(r(k));
        
        X1new = X+x1vector(m, k); Y1new = Y+y1vector(m, k);
        X2new = X+x2vector(m, k); Y2new = Y+y2vector(m, k);

        h(k) = fill(X1new, Y1new, 'r');
        r(k) = fill(X2new, Y2new, 'b');    
    end
    delete(moleculetext1);
    delete(moleculetext2);
    
    moleculetext1 = text(textxvector1(m), textyvector1(m), 'B Segment', 'fontsize', fontsizeD, 'color', 'b');
    moleculetext2 = text(textxvector2(m), textyvector2(m), 'A Segment', 'fontsize', fontsizeD, 'color', 'r');    
    
    pause(0.02);
end

%Setting the new values for the Polymer and Text Coordinates for the next
%repeat
for k = 1:8
    x1center(k) = x1vector(30, k);
    y1center(k) = y1vector(30, k);
    x2center(k) = x2vector(30, k);
    y2center(k) = y2vector(30, k);
end

textx1 = textxvector1(30); texty1 = textyvector1(30);
textx2 = textxvector2(30); texty2 = textyvector2(30);

%Making Handles of all structures that must be saved or reused
handles.ECP.h = h;
handles.ECP.r = r;
handles.ECP.x1center = x1center; handles.ECP.y1center = y1center;
handles.ECP.x2center = x2center; handles.ECP.y2center = y2center;
handles.ECP.textx1 = textx1; handles.ECP.texty1 = texty1;
handles.ECP.textx2 = textx2; handles.ECP.texty2 = texty2;
handles.ECP.moleculetext1 = moleculetext1; handles.ECP.moleculetext2 = moleculetext2;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%------This Section is for Enthalpy of Mixing----------------
%------------------------------------------------------------
function EMstart_Callback(hObject, eventdata, handles)
set(handles.CPanimate, 'visible', 'off');
set(handles.ECPanimate, 'visible', 'off');
set(handles.EManimate, 'visible', 'on');
set(handles.IEManimate, 'visible', 'off');
set(handles.MSanimate, 'visible', 'off');
set(handles.entropytext, 'string', ' ');
struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 25 0 25]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');
color2 = ['r' 'r' 'b'];

square1x = [1 1 3 3 3 3 5 5 5 5 7 7 1 1 3 3 3 3 5 5 5 5 7 7 1 1 3 3 3 3 5 5 5 5 7 7];
square1y = [17 15 15 17 17 15 15 17 17 15 15 17 15 13 13 15 15 13 13 15 15 13 13 15 13 11 11 13 13 11 11 13 13 11 11 13];

square1 = zeros(9, 1);
for k = 1:4:33;
    square1(k) = fill(square1x(k:(k+3)), square1y(k:(k+3)), 'b');
end

square2x = [18 18 20 20 20 20 22 22 22 22 24 24 18 18 20 20 22 22 24 24 18 18 20 20 20 20 22 22 22 22 24 24];
square2y = [17 15 15 17 17 15 15 17 17 15 15 17 15 13 13 15 15 13 13 15 13 11 11 13 13 11 11 13 13 11 11 13];
color = ['r' 'b' 'b' 'r' 'r' 'b' 'r' 'b'];
q = zeros(1,29);
q(1) = 1; q(5) = 2; q(9) = 3; q(13) = 4; q(17) = 5; q(21) = 6; q(25) = 7; q(29) = 8;

square2 = zeros(8, 1);
for j = 1:4:29;
    square2(j) = fill(square2x(j:(j+3)), square2y(j:(j+3)), color(q(j)));
end

handles.CP.square1 = square1;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in EManimate.
function EManimate_Callback(hObject, eventdata, handles)

struct2var(handles.CP);
struct2var(handles.font);
set(handles.CPanimate, 'visible', 'off');

x1vector = linspace(3, 20, 50);
x2vector = linspace(3, 20, 50);
x3vector = linspace(5, 22, 50);
x4vector = linspace(5, 22, 50);

y1vector = 15; y2vector = 13; y3vector = 13; y4vector = 15;

for m = 1:length(x1vector);
    delete(square1(17));
    square1(17) = fill([x1vector(m) x2vector(m) x3vector(m) x4vector(m)], [y1vector y2vector y3vector y4vector], 'b');
    
    pause(0.02);
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%-----This Section is for Ideal Entropy of Mixing---------
%---------------------------------------------------------
function IEMstart_Callback(hObject, eventdata, handles)
set(handles.CPanimate, 'visible', 'off');
set(handles.ECPanimate, 'visible', 'off');
set(handles.EManimate, 'visible', 'off');
set(handles.IEManimate, 'visible', 'on');
set(handles.MSanimate, 'visible', 'off');
set(handles.entropytext, 'string', ' ');
struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);
axis(handles.axes1, [0 24 0 24]);
axis(handles.axes1, 'square');
hold(handles.axes1, 'on');

%Creating the Grid Lines
xh = [9 15]; yv = [9 15];
yh = zeros(1, 7); xv = zeros(1, 7);

for k = 1:7
    yh(k) = k+8;
    xv(k) = k+8;
    
    plot(xh, [yh(k) yh(k)]);
    plot([xv(k) xv(k)], yv);
    
end

%Creating the Squares
squarex = [1 1 2 2; 3 3 4 4; 5 5 6 6; 1 1 2 2; 3 3 4 4; 5 5 6 6; 1 1 2 2; 3 3 4 4; 5 5 6 6; 1 1 2 2; 3 3 4 4; 5 5 6 6; 1 1 2 2; 3 3 4 4; 5 5 6 6; 1 1 2 2; 3 3 4 4; 5 5 6 6; 18 18 19 19; 20 20 21 21; 22 22 23 23; 18 18 19 19; 20 20 21 21; 22 22 23 23; 18 18 19 19; 20 20 21 21; 22 22 23 23; 18 18 19 19; 20 20 21 21; 22 22 23 23; 18 18 19 19; 20 20 21 21; 22 22 23 23; 18 18 19 19; 20 20 21 21; 22 22 23 23];
squarey = [18 17 17 18; 18 17 17 18; 18 17 17 18; 16 15 15 16; 16 15 15 16; 16 15 15 16; 14 13 13 14; 14 13 13 14; 14 13 13 14; 12 11 11 12; 12 11 11 12; 12 11 11 12; 10 9 9 10; 10 9 9 10; 10 9 9 10; 8 7 7 8; 8 7 7 8; 8 7 7 8; 18 17 17 18; 18 17 17 18; 18 17 17 18; 16 15 15 16; 16 15 15 16; 16 15 15 16; 14 13 13 14; 14 13 13 14; 14 13 13 14; 12 11 11 12; 12 11 11 12; 12 11 11 12; 10 9 9 10; 10 9 9 10; 10 9 9 10; 8 7 7 8; 8 7 7 8; 8 7 7 8];
squares = zeros(1, 36);

for k = 1:size(squarex, 1);
    if k <= 18;
        squares(k) = fill(squarex(k, 1:4), squarey(k, 1:4), 'r');
    else
        squares(k) = fill(squarex(k, 1:4), squarey(k, 1:4), 'b');
    end
end

%Creating a Marker and other details to be used exclusively in the animation
marker = 1;
gridx = [9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15; 9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15; 9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15; 9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15; 9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15; 9 9 10 10; 10 10 11 11; 11 11 12 12; 12 12 13 13; 13 13 14 14; 14 14 15 15];
gridy = [15 14 14 15; 15 14 14 15; 15 14 14 15; 15 14 14 15; 15 14 14 15; 15 14 14 15; 14 13 13 14; 14 13 13 14; 14 13 13 14; 14 13 13 14; 14 13 13 14; 14 13 13 14; 13 12 12 13; 13 12 12 13; 13 12 12 13; 13 12 12 13; 13 12 12 13; 13 12 12 13; 12 11 11 12; 12 11 11 12; 12 11 11 12; 12 11 11 12; 12 11 11 12; 12 11 11 12; 11 10 10 11; 11 10 10 11; 11 10 10 11; 11 10 10 11; 11 10 10 11; 11 10 10 11; 10 9 9 10; 10 9 9 10; 10 9 9 10; 10 9 9 10; 10 9 9 10; 10 9 9 10];

handles.IEM.marker = marker;
handles.IEM.squares = squares;
handles.IEM.squarex = squarex; handles.IEM.squarey = squarey;
handles.IEM.gridx = gridx;
handles.IEM.gridy = gridy;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in IEManimate.
function IEManimate_Callback(hObject, eventdata, handles)

struct2var(handles.IEM);
struct2var(handles.font);

hold(handles.axes1, 'on');

if marker == 1;
    
    tracker = 1:36;
    q = 1;
    
    r = randi(36);
    
    xvector1 = linspace(squarex(q, 1), gridx(r, 1), 10);
    xvector2 = linspace(squarex(q, 2), gridx(r, 2), 10);
    xvector3 = linspace(squarex(q, 3), gridx(r, 3), 10);
    xvector4 = linspace(squarex(q, 4), gridx(r, 4), 10);
    
    yvector1 = linspace(squarey(q, 1), gridy(r, 1), 10);
    yvector2 = linspace(squarey(q, 2), gridy(r, 2), 10);
    yvector3 = linspace(squarey(q, 3), gridy(r, 3), 10);
    yvector4 = linspace(squarey(q, 4), gridy(r, 4), 10);
    
    for k = 1: length(xvector1);
        delete(squares(q));
        
        squares(q) = fill([xvector1(k) xvector2(k) xvector3(k) xvector4(k)], [yvector1(k) yvector2(k) yvector3(k) yvector4(k)], 'r');
        
        pause(0.0001);
    end
    
    q = q+1;
    tracker(r) = 0;
    marker = marker+1;
    
    %Creating Handles for values required later
    handles.IEM.tracker = tracker; handles.IEM.q = q;
    handles.IEM.squares = squares;
    handles.IEM.marker = marker;
    handles.IEM.squarex = squarex; handles.IEM.squarey = squarey;
    handles.IEM.gridx = gridx; handles.IEM.gridy = gridy;
    guidata(hObject, handles);
    
    %Setting Text
    set(handles.entropytext, 'string', 'There are 36 sites on the lattice, so there are 36 possibilities for the placement of the first molecule. Please press "animate" again to continue.', 'fontsize', fontsizeC);
    
elseif marker == 2;
    
    r = randi(36);
    
    xvector1 = linspace(squarex(q, 1), gridx(r, 1), 10);
    xvector2 = linspace(squarex(q, 2), gridx(r, 2), 10);
    xvector3 = linspace(squarex(q, 3), gridx(r, 3), 10);
    xvector4 = linspace(squarex(q, 4), gridx(r, 4), 10);
    
    yvector1 = linspace(squarey(q, 1), gridy(r, 1), 10);
    yvector2 = linspace(squarey(q, 2), gridy(r, 2), 10);
    yvector3 = linspace(squarey(q, 3), gridy(r, 3), 10);
    yvector4 = linspace(squarey(q, 4), gridy(r, 4), 10);
    
    for k = 1: length(xvector1);
        delete(squares(q));
        
        squares(q) = fill([xvector1(k) xvector2(k) xvector3(k) xvector4(k)], [yvector1(k) yvector2(k) yvector3(k) yvector4(k)], 'r');
        
        pause(0.0001);
    end
    
    q = q+1;
    tracker(r) = 0;
    marker = marker+1;
    
    %Creating Handles for values required later
    handles.IEM.tracker = tracker; handles.IEM.q = q;
    handles.IEM.squares = squares;
    handles.IEM.marker = marker;
    handles.IEM.squarex = squarex; handles.IEM.squarey = squarey;
    handles.IEM.gridx = gridx; handles.IEM.gridy = gridy;
    guidata(hObject, handles);
    
    %Setting Text:
    set(handles.entropytext, 'string', 'There are 35 sites remaining for the placement of the second site, 34 for the 3rd site, etc. To continue, press "animate" again', 'fontsize', fontsizeC);
    
elseif q == 3;
    
    %Setting Text:
    set(handles.IEManimate, 'visible', 'off');
    set(handles.entropytext, 'string', 'This is only one of many possible combinations. The total number of possibilities is 36*35*34...*2*1 = 36!', 'fontsize', fontsizeC); 
    
    while sum(tracker) > 0;
        r = randi(36);
        
        if tracker(r) > 0;
            
            xvector1 = linspace(squarex(q, 1), gridx(r, 1), 5);
            xvector2 = linspace(squarex(q, 2), gridx(r, 2), 5);
            xvector3 = linspace(squarex(q, 3), gridx(r, 3), 5);
            xvector4 = linspace(squarex(q, 4), gridx(r, 4), 5);
            
            yvector1 = linspace(squarey(q, 1), gridy(r, 1), 5);
            yvector2 = linspace(squarey(q, 2), gridy(r, 2), 5);
            yvector3 = linspace(squarey(q, 3), gridy(r, 3), 5);
            yvector4 = linspace(squarey(q, 4), gridy(r, 4), 5);
            
            for k = 1: length(xvector1);
                delete(squares(q));
                
                if q <= 18;
                    squares(q) = fill([xvector1(k) xvector2(k) xvector3(k) xvector4(k)], [yvector1(k) yvector2(k) yvector3(k) yvector4(k)], 'r');
                else
                    squares(q) = fill([xvector1(k) xvector2(k) xvector3(k) xvector4(k)], [yvector1(k) yvector2(k) yvector3(k) yvector4(k)], 'b');
                end
                
                pause(0.0001);
            end
            
            q = q+1;
            tracker(r) = 0;
        end
        
    end
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% -----This Section is for the Mixing Simulation Animation--------
% ----------------------------------------------------------------
function MSstart_Callback(hObject, eventdata, handles)

set(handles.CPanimate, 'visible', 'off');
set(handles.ECPanimate, 'visible', 'off');
set(handles.EManimate, 'visible', 'off');
set(handles.IEManimate, 'visible', 'off');
set(handles.MSanimate, 'visible', 'on');
set(handles.entropytext, 'string', ' ');
struct2var(handles.font);

cla(handles.axes1);
reset(handles.axes1);

axis(handles.axes1, [0 32 0 32]);
hold(handles.axes1, 'on');

%Creating the Squares
squarevectorx = zeros(4, 900); %Creating X-value Vectors
squarevectory = zeros(4, 900); %Creating Y-value Vectors

counter = 0; %Creating Counter to get up to 324

for n = 1:30; %Plotting the Lattice of Points
    for m = 1:30;
        counter = counter+1;
        
        squarevectorx(:,counter) = [m m+1 m+1 m];
        squarevectory(:,counter) = [n n n+1 n+1];
    end
end

colorvector = zeros(1, 900);
colortracker = zeros(1, 900);
for k = 1:length(squarevectorx); %Setting the Colors of each Square Randomly
    
    r = randi(2);
    
    colortracker(k) = r;
    
    if r == 1
        colorvector(k) = 'r';
    elseif r == 2
        colorvector(k) = 'b';
    end
end

squares = zeros(1, 900); %Drawing the Squares
for k = 1:length(squarevectorx);
    squares(k)=patch([squarevectorx(:, k)], [squarevectory(:, k)], colorvector(k));
end

handles.MS.squarevectorx = squarevectorx;
handles.MS.squarevectory = squarevectory;
handles.MS.squares = squares;
handles.MS.colorvector = colorvector;
handles.MS.colortracker = colortracker;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in MSanimate.
function MSanimate_Callback(hObject, eventdata, handles)

struct2var(handles.MS);
struct2var(handles.font);

if get(handles.MSanimate, 'value') == 0;
    set(handles.MSanimate, 'visible', 'off');
end

chival = str2double(get(handles.chivalue, 'string')); %getting the chi value

while get(handles.MSanimate, 'value') == 1;
    
    square1 = randi(length(squarevectorx));
    
    n = randi(4);
    
    if n == 1 & mod(square1, 30) ~= 0; %Switch with the Right Normal
        square2 = square1+1;
    elseif n == 1 & mod(square1, 30) == 0; %Switch with the Right Unique
        square2 = square1-29;
    elseif n == 2 & mod(square1, 30) ~= 1; %Switch with the Left Normal
        square2 = square1-1;
    elseif n == 2 & mod(square1, 30) == 1; %Switch with the Left Unique
        square2 = square1+29;
    elseif n == 3 & square1 < 871; %Switch with Above Normal
        square2 = square1+30;
    elseif n == 3 & square1 >= 871; %Switch with the Above Unique
        square2 = square1 - 870;
    elseif n == 4 & square1 > 30; %Switch with Below Normal
        square2 = square1-30;
    elseif n == 4 & square1 <= 30; %Switch with the Below Unique
        square2 = square1+870;
    end
    
    if colortracker(square1) ~= colortracker(square2);
        %Square 1 Tracking
        if mod(square1, 30) ~= 0;
            rightsquare1 = square1+1;
        elseif mod(square1, 30) == 0;
            rightsquare1 = square1-29;
        end
        
        if mod(square1, 30) ~= 1;
            leftsquare1 = square1-1;
        elseif mod(square1, 30) == 1;
            leftsquare1 = square1+29;
        end
        
        if square1 < 871;
            topsquare1 = square1+30;
        elseif square1 >= 871;
            topsquare1 = square1-870;
        end
        
        if square1 > 30;
            bottomsquare1 = square1-30;
        elseif square1 <= 30;
            bottomsquare1 = square1+870;
        end
        
        %Square 2 Tracking
        if mod(square2, 30) ~= 0;
            rightsquare2 = square2+1;
        elseif mod(square2, 30) == 0;
            rightsquare2 = square2-29;
        end
        
        if mod(square2, 30) ~= 1;
            leftsquare2 = square2-1;
        elseif mod(square2, 30) == 1;
            leftsquare2 = square2+29;
        end
        
        if square2 < 871;
            topsquare2 = square2+30;
        elseif square2 >= 871;
            topsquare2 = square2-870;
        end
        
        if square2 > 30;
            bottomsquare2 = square2-30;
        elseif square2 <= 30;
            bottomsquare2 = square2+870;
        end
        
        comparevector1 = [colortracker(rightsquare1) colortracker(leftsquare1) colortracker(topsquare1) colortracker(bottomsquare1)];
        comparevector2 = [colortracker(rightsquare2) colortracker(leftsquare2) colortracker(topsquare2) colortracker(bottomsquare2)];
        
        dif1 = 0;
        dif2 = 0;
        for k = 1:4;
            
            if colortracker(square1) ~= comparevector1(k);
                dif1 = dif1+1;
            end
            if colortracker(square1) ~= comparevector2(k);
                dif2 = dif2+1;
            end
        end
        
        change = dif2-dif1; %calculating change in number of contacts
        energy = chival/4*change; %calculating energy
        
        if energy < 0;
            accept = 1;
        elseif energy >= 0;
            moveprob = exp(-energy); %calculating moving probability
            comparenumber = rand;
            
            if moveprob >= comparenumber;
                accept = 1;
            else
                accept = 0;
            end
        end
        
        if accept == 1;
            
            square1color = colorvector(square1);
            square2color = colorvector(square2);
            square1track = colortracker(square1);
            square2track = colortracker(square2);
            color1num = get(squares(square1), 'CData');
            color2num = get(squares(square2), 'CData');
            
            
            set(squares(square1), 'CData', color2num);
            set(squares(square2), 'CData', color1num);
            
               colorvector(square1) = square2color;
               colorvector(square2) = square1color;
               colortracker(square1) = square2track;
               colortracker(square2) = square1track;
                          
            pause(0.001);
            
        end
   
    end   
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

% --- Executes on button press in CPdetail.
function CPdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Chemical Potentials');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

CPdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Chemical Potentials');
CPdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(CPdetailtext, 'string', stringtext);
set(CPdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in ECPdetail.
function ECPdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Exchange Chemical Potentials');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

ECPdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Exchange Chemical Potentials');
ECPdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(ECPdetailtext, 'string', stringtext);
set(ECPdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in IEMdetail.
function IEMdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Ideal Entropy of Mixing');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

IEMdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Ideal Entropy of Mixing');
IEMdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(IEMdetailtext, 'string', stringtext);
set(IEMdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

% --- Executes on button press in MSdetail.
function MSdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);
stringid = cellstr('Mixing Simulation');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"
MSdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Mixing Simulation');
MSdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold','horizontalalignment', 'left');
set(MSdetailtext, 'string', stringtext);
set(MSdetailtext, 'position', [50 50 300 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

