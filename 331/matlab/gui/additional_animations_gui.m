function varargout = additional_animations_gui(varargin)
% ADDITIONAL_ANIMATIONS_GUI MATLAB code for additional_animations_gui.fig
%      ADDITIONAL_ANIMATIONS_GUI, by itself, creates a new ADDITIONAL_ANIMATIONS_GUI or raises the existing
%      singleton*.
%
%      H = ADDITIONAL_ANIMATIONS_GUI returns the handle to a new ADDITIONAL_ANIMATIONS_GUI or the handle to
%      the existing singleton*.
%
%      ADDITIONAL_ANIMATIONS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDITIONAL_ANIMATIONS_GUI.M with the given input arguments.
%
%      ADDITIONAL_ANIMATIONS_GUI('Property','Value',...) creates a new ADDITIONAL_ANIMATIONS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before additional_animations_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to additional_animations_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help additional_animations_gui

% Last Modified by GUIDE v2.5 14-Jan-2014 10:12:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @additional_animations_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @additional_animations_gui_OutputFcn, ...
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


% --- Executes just before additional_animations_gui is made visible.
function additional_animations_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to additional_animations_gui (see VARARGIN)

% Choose default command line output for additional_animations_gui
fontsize0 = getappdata(0, 'fontsize0');
fontsizeA = getappdata(0, 'fontsizeA');
fontsizeB = getappdata(0, 'fontsizeB');
fontsizeC = getappdata(0, 'fontsizeC');
fontsizeD = getappdata(0, 'fontsizeD');
fontsizeE = getappdata(0, 'fontsizeE');
fontsizeF = getappdata(0, 'fontsizeF');

handles.font.fontsize0 = fontsize0;
handles.font.fontsizeA = fontsizeA;
handles.font.fontsizeB = fontsizeB;
handles.font.fontsizeC = fontsizeC;
handles.font.fontsizeD = fontsizeD;
handles.font.fontsizeE = fontsizeE;
handles.font.fontsizeF = fontsizeF;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes additional_animations_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = additional_animations_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- This Section is for Chain Growth Mechanisms ----------
% ----------------------------------------------------------
function mechanismstart_Callback(hObject, eventdata, handles)

%Setting up the Axes
cla(handles.axes1); reset(handles.axes1);
xlim(handles.axes1, [0 25]); ylim(handles.axes1, [0, 15]);
struct2var(handles.font);
hold on;

%Making action buttons visible
set(handles.DBanimation, 'visible', 'on');
set(handles.ROanimation, 'visible', 'on');
set(handles.CTanimate, 'visible', 'off');
set(handles.ICTanimate, 'visible', 'off');
set(handles.TDanimate, 'visible', 'off');
set(handles.TCanimate, 'visible', 'off');

%Creating the Polymer Molecule
r = 0.3;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
xcenter = [2 2.6 2.9 3.5 3.9 4.45 5 5.5 6.1 6.6];
ycenter = [10 10.2 10.7 10.8 10.4 10.1 9.9 10.3 10.3 10.6];

h = zeros(1, length(xcenter));

for k = 1:length(xcenter);
    Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
    h(k)=fill(Xnew,Ynew,'r');
end

asterisk = text(7.1, 10.6, '*', 'fontsize', fontsizeD);

%Creating Writing and such
polymertext = text(1, 12.5, 'Growing Polymer Chain', 'fontsize', fontsizeA);

xletters = [15 15.5 18.5 18 15.5 18 16.75 15.5 18 15.5 18 15.5 18];
yletters = [12 10.5 12 10.5 11.25 11.25 13 5 5 3.5 3.5 4.25 4.25];
lettertext = ['H' 'H' 'H' 'H' 'C' 'C' 'O' 'H' 'H' 'H' 'H' 'C' 'C'];
letters = zeros(1, 13);

for q = 1:length(letters);
    letters(q) = text(xletters(q), yletters(q), lettertext(q), 'fontsize', fontsizeA);
end

%Creating the Bonds
ccbondx = linspace(16.25, 17.75, 50);
ccbondy = 11.25;
cobondx1 = linspace(16.0, 16.7, 50);
cobondy1 = 1.05.*cobondx1-5;
cobondx2 = linspace(17.25, 17.95, 50);
cobondy2 = -1.05.*cobondx2+30.7;
ccdoublebondy1 = 4.4;
ccdoublebondy2 = 4.2;

b1 = plot(ccbondx, ccbondy, 'k');
b2 = plot(cobondx1, cobondy1, 'k');
b3 = plot(cobondx2, cobondy2, 'k');
b4 = plot(ccbondx, ccdoublebondy1, 'k');
b5 = plot(ccbondx, ccdoublebondy2, 'k');

%Creating Handles
handles.chaingrowth.b2 = b2; handles.chaingrowth.b4 = b4;
handles.chaingrowth.h = h;
handles.chaingrowth.asterisk = asterisk;
handles.chaingrowth.xcenter = xcenter; handles.chaingrowth.ycenter = ycenter;
handles.chaingrowth.X = X; handles.chaingrowth.Y = Y;

guidata(hObject,handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in DBanimation.
function DBanimation_Callback(hObject, eventdata, handles)

struct2var(handles.chaingrowth);
struct2var(handles.font);
%Turning off button visibility
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');

xvector = zeros(20, 13);

for t = 1:length(xcenter);
    xvector(1:20, t) = linspace(xcenter(t), xcenter(t)+8.2, 20);
    yvector(1:20, t) = linspace(ycenter(t), ycenter(t)-6.35, 20);
end

asteriskx = linspace(7.1, 15.3, 20);
asterisky = linspace(10.6, 4.25, 20);

asteriskx2 = linspace(15.3, 18.6, 20);

for s = 1:length(xvector);
    
    for t = 1:length(xcenter);
        delete(h(t));
        Xnew = X+xvector(s, t); Ynew = Y+yvector(s, t);
        h(t) = fill(Xnew, Ynew, 'r');
        
        xlim(handles.axes1, [0, 25]);
        ylim(handles.axes1, [0, 15]);
    end
    
    delete(asterisk);
    asterisk = text(asteriskx(s), asterisky(s), '*', 'fontsize', fontsizeD);
    
    pause(0.02);
end

for u = 1:length(asteriskx2);
    delete(asterisk);
    asterisk = text(asteriskx2(u), 4.25, '*', 'fontsize', fontsizeD);
    
    pause(0.02);
end

delete(b4);

%Creating lines and text
line1x = linspace(11, 15, 20);
line1y = linspace(7, 5, 20);
line2x = linspace(17, 18, 20);
line2y = linspace(5, 6, 20);

plot(line1x, line1y, 'b');
plot(line2x, line2y, 'b');

detail1 = text(2, 8, 'A new bond is formed between the \newline growing chain and the monomer', 'fontsize', fontsize0, 'color', 'b');
detail2 = text(15.5, 8, 'The double bond becomes \newline a single bond, and the \newline reactive end moves to the \newline end of the growing molecule', 'fontsize', fontsize0, 'color', 'b');

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in ROanimation.
function ROanimation_Callback(hObject, eventdata, handles)

struct2var(handles.chaingrowth);
struct2var(handles.font);
%Turning off button visibility
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');

xvector = zeros(20, 13);

for t = 1:length(xcenter);
    xvector(1:20, t) = linspace(xcenter(t), xcenter(t)+8.2, 20);
    yvector(1:20, t) = linspace(ycenter(t), ycenter(t)+0.6, 20);
end

asteriskx = linspace(7.1, 15.3, 20);
asterisky = linspace(10.6, 11.2, 20);

asteriskx2 = linspace(15.3, 16.5, 20);
asterisky2 = linspace(11.2, 13.3, 20);

for s = 1:length(xvector);
    
    for t = 1:length(xcenter);
        delete(h(t));
        Xnew = X+xvector(s, t); Ynew = Y+yvector(s, t);
        h(t) = fill(Xnew, Ynew, 'r');
        
        xlim(handles.axes1, [0, 25]);
        ylim(handles.axes1, [0, 15]);
    end
    
    delete(asterisk);
    asterisk = text(asteriskx(s), asterisky(s), '*', 'fontsize', fontsizeD);
    
    pause(0.02);
end

for u = 1:length(asteriskx2);
    delete(asterisk);
    asterisk = text(asteriskx2(u), asterisky2(u), '*', 'fontsize', fontsizeD);
    
    pause(0.02);
end

delete(b2);

%Creating lines and text
line1x = linspace(11, 15, 20);
line1y = linspace(9, 10.5, 20);
line2x = linspace(17.5, 19, 30);

plot(line1x, line1y, 'b');
plot(line2x, 13.5, 'b');

detail1 = text(2, 8, 'A new bond is formed between the \newline growing chain and the monomer', 'fontsize', fontsize0, 'color', 'b');
detail2 = text(19.5, 12.5, 'A bond in the \newline ring is broken \newline and the reactive \newline site moves to \newline the end of the \newline molecule', 'fontsize', fontsize0, 'color', 'b');

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%----------------This Section is for Chain Transfer Animation---
%---------------------------------------------------------------
function CTstart_Callback(hObject, eventdata, handles)

%Making Buttons Visible
set(handles.CTanimate, 'visible', 'on');
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');
set(handles.ICTanimate, 'visible', 'off');
set(handles.TDanimate, 'visible', 'off');
set(handles.TCanimate, 'visible', 'off');
struct2var(handles.font);

%Setting up the Axes
cla(handles.axes1);reset(handles.axes1);
xlim(handles.axes1, [0 19]);
ylim(handles.axes1, [0, 14]);
hold on;

%Creating the Polymer Molecule
r = 0.3;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
xcenter = [2 2.6 2.9 3.5 3.9 4.45 5 5.5 6.1 6.6];
ycenter = [6 6.2 6.7 6.8 6.4 6.1 5.9 6.3 6.3 6.6];

h = zeros(1, length(xcenter));

for k = 1:length(xcenter);
    Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
    h(k)=fill(Xnew,Ynew,'r');
end

H1 = text(7, 7.5, 'H', 'fontsize', fontsizeB);
H2 = text(7, 5.9, 'H', 'fontsize', fontsizeB);
C1 = text(7, 6.7, 'C', 'fontsize', fontsizeB, 'color', 'r');

%Creating the Toluene
toltheta = 0:60:360;
tolx = 1.5.*cosd(toltheta+30)+15;
toly = 1.5.*sind(toltheta+30)+6;
plot(tolx, toly, 'b-'); %Hexagon

plot(3.7.*X+15, 3.7.*Y+6); %Circle

C2 = text(14.7, 8.2, 'C', 'fontsize', fontsizeB);
H3 = text(13.9, 8.2, 'H', 'fontsize', fontsizeB);
H4 = text(15.5, 8.2, 'H', 'fontsize', fontsizeB);
H5 = text(14.7, 9.5, 'H', 'fontsize', fontsizeB);

%Creating the Electrons
re = 0.16;
rho=ones(1,N)*re;
[Xe,Ye] = pol2cart(theta,rho);
radxcenter = [7.8 14.75 15.25];
radycenter = [6.4 8.8 8.8];
ecolor = ['r', 'k', 'k'];

for k = 1:length(radxcenter);
    Xenew=Xe+radxcenter(k); Yenew=Ye+radycenter(k);
    e(k)=fill(Xenew,Yenew, ecolor(k));
end

handles.CT.h = h; handles.CT.e = e;
handles.CT.H5 = H5; handles.CT.C1 = C1; handles.CT.C2 = C2;
handles.CT.Xe = Xe; handles.CT.Ye = Ye;
handles.CT.radxcenter = radxcenter; handles.CT.radycenter = radycenter;
guidata(hObject,handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in CTanimate.
function CTanimate_Callback(hObject, eventdata, handles)

struct2var(handles.CT);
struct2var(handles.font);

%Turning off visibility
set(handles.CTanimate, 'visible', 'off');

%Creating Movement Vectors
Hxvector = linspace(14.7, 8.1, 30);
Hyvector = linspace(9.5, 6.7, 30);

exvector1 = linspace(radxcenter(2), radxcenter(2)-6.95, 30);
eyvector1 = linspace(radycenter(2), radycenter(2)-1.9, 30);

for k = 1:length(Hxvector);
    delete(e(2));
    delete(H5);

    H5 = text(Hxvector(k), Hyvector(k), 'H', 'fontsize', fontsizeB);
    Xenew=Xe+exvector1(k); Yenew=Ye+eyvector1(k);
    e(2)=fill(Xenew,Yenew, 'r');
    
    pause(0.02);
end

pause(0.05);

%Changing Colors of final positions
delete(C1);
delete(C2);
C1 = text(7, 6.7, 'C', 'fontsize', fontsizeB, 'color', 'k');
C2 = text(14.7, 8.2, 'C', 'fontsize', fontsizeB, 'color', 'r');

newexcenter = [7.8 7.8 15.25];
neweycenter = [6.4 6.9 8.8];
newcolor = ['k' 'k' 'r'];

for k = 1:length(newexcenter);
    delete(e(k));
    Xenew = Xe+newexcenter(k); Yenew = Ye+neweycenter(k);
    e(k) = fill(Xenew, Yenew, newcolor(k));
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%------------------This Section is for Intramolecular Chain Transfer---
%----------------------------------------------------------------------
function ICTstart_Callback(hObject, eventdata, handles)

set(handles.ICTanimate, 'visible', 'on');
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');
set(handles.CTanimate, 'visible', 'off');
set(handles.TDanimate, 'visible', 'off');
set(handles.TCanimate, 'visible', 'off');
struct2var(handles.font);

%Setting up the Axes
cla(handles.axes1); reset(handles.axes1);
xlim(handles.axes1, [0 12]);
ylim(handles.axes1, [0, 8]);
hold on;

%Creating the Polymer Molecule
r = 0.3;
N = 1000;
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);
xcenter = [2 2.6 2.9 3.5 3.9 4.45 5 5.5 6.1 6.6];
ycenter = [3 3.2 3.7 3.8 3.4 3.1 2.9 3.3 3.3 3.6];

h = zeros(1, length(xcenter));

for k = 1:length(xcenter);
    Xnew=X+xcenter(k); Ynew=Y+ycenter(k);
    h(k)=fill(Xnew,Ynew,'r');
end

%Creating the Letters
C1 = text(7, 3.6, 'C', 'fontsize', fontsizeF, 'fontweight', 'bold');
H1 = text(7, 4.6, 'H', 'fontsize', fontsizeF, 'fontweight', 'bold');
R1 = text(6.7, 2.8, 'R', 'fontsize', fontsizeF, 'fontweight', 'bold');
CH1 = text(8, 2.3, 'CH_{2}', 'fontsize', fontsizeF,'fontweight', 'bold');
CHR1 = text(10, 3.5, 'CHR', 'fontsize', fontsizeF, 'fontweight', 'bold');
CH2 = text(10, 4.2, 'CH_{2}', 'fontsize', fontsizeF,'fontweight', 'bold');
CHR2 = text(9, 5.5, 'CHR', 'fontsize', fontsizeF,'fontweight', 'bold');

%Creating the Bonds
bond1x = linspace(7.6, 8, 20);
bond1y = linspace(3.3, 2.9, 20);

bond2x = linspace(9.3, 10, 20);
bond2y = linspace(2.8, 3.1, 20);

bond3y = linspace(3.8, 4.1, 20);

bond4x = linspace(9.9, 9.5, 20);
bond4y = linspace(4.7, 5, 20);

plot(bond1x, bond1y, 'k', 'linewidth', 2);
plot(bond2x, bond2y, 'k', 'linewidth', 2);
plot(10.2, bond3y, 'k', 'linewidth', 2);
plot(bond4x, bond4y, 'k', 'linewidth', 2);

%Creating the Electrons
re = 0.12;
rho=ones(1,N)*re;
[Xe,Ye] = pol2cart(theta,rho);
xecenter = [7.1 7.5 9.5];
yecenter = [4 4 5.9];
ecolor = ['k', 'k', 'r'];

for k = 1:length(xecenter);
    Xenew=Xe+xecenter(k); Yenew=Ye+yecenter(k);
    e(k)=fill(Xenew,Yenew, ecolor(k));
end

%Creating Handles
handles.ICT.H1 = H1;
handles.ICT.e = e;
handles.ICT.Xe = Xe; handles.ICT.Ye = Ye;
handles.ICT.xecenter = xecenter; handles.ICT.yecenter = yecenter;

guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in ICTanimate.
function ICTanimate_Callback(hObject, eventdata, handles)

struct2var(handles.ICT);
struct2var(handles.font);

%Turning off visibility
set(handles.ICTanimate, 'visible', 'off');

%Creating Movement Vectors
Hxvector = linspace(7, 9, 30);
Hyvector = linspace(4.6, 6.5, 30);

exvector1 = linspace(xecenter(1), xecenter(1)+2, 30);
eyvector1 = linspace(yecenter(1), yecenter(1)+1.9, 30);

for k = 1:length(Hxvector);
    delete(e(1));
    delete(H1);

    H1 = text(Hxvector(k), Hyvector(k), 'H', 'fontsize', fontsizeF,'fontweight', 'bold');
    Xenew=Xe+exvector1(k); Yenew=Ye+eyvector1(k);
    e(1)=fill(Xenew,Yenew, 'r');
    
    pause(0.02);
end

pause(0.05);

%Changing Colors of final positions
newxecenter = [9.1 7.5 9.5];
newyecenter = [5.9 4 5.9];
newcolor = ['k', 'r', 'k'];

for k = 1:length(newxecenter);
    delete(e(k));
    Xenew = Xe+newxecenter(k); Yenew = Ye+newyecenter(k);
    e(k) = fill(Xenew, Yenew, newcolor(k));
end

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

%----------This Section is for Termination by Disproportionation---
%------------------------------------------------------------------
function TDstart_Callback(hObject, eventdata, handles)

cla(handles.axes1); reset(handles.axes1);
set(handles.ICTanimate, 'visible', 'off');
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');
set(handles.CTanimate, 'visible', 'off');
set(handles.TDanimate, 'visible', 'on');
set(handles.TCanimate, 'visible', 'off');
struct2var(handles.font);

xlim([0, 25]); ylim([0,15]);
r = 0.5;
N = 1000;
color1 = ['k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k'];
color2 = ['k', 'k', 'k', 'k', 'k', 'k'];
color3 = ['r', 'r', 'k', 'k', 'r', 'r'];
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

%left polymer circles
x1center = [6 5.1 4.2 4.5 5 6 6.9 7.7 8.7 9.6];
y1center = [10 10.5 10 9 8.1 8 7.8 8.5 8.7 9.1];

%right polymer circles
x2center = [20 21 21.1 21.4 20.8 19.8];
y2center = [12 11.8 10.8 9.8 9 9.1];

%molecule electrons (stationary)
r1 = 0.16;
rho1=ones(1,N)*r1;
xecenter = [10.2 10.8 10.2 10.8 9.8 9.8 19.2 19.8 19.2 19.8 20.2 20.2 21.2 21.8 22.2 22.2];
yecenter = [4.3 4.3 2.7 2.7 3.7 3.2 4.3 4.3 2.7 2.7 3.7 3.2 2.7 2.7 3.7 3.2];
[X3, Y3] = pol2cart(theta, rho1);

%molecule electrons (mobile)
xemcenter = [11.2 18.8 21.2 21.8 11.8 15.7];
yemcenter = [3.2 3.7 4.3 4.3 8.7 9.2];

hold on;

h = zeros(1, length(x1center));
n = zeros(1, length(x2center));
m = zeros(1, length(xecenter));

%generating each set of polymer/electron circles
for k = 1:length(x1center);
    X1new=X+x1center(k); Y1new=Y+y1center(k);
    leftpolymer(k)=fill(X1new,Y1new,color1(k));
end

for g = 1:length(x2center);
    X2new = X+x2center(g); Y2new = Y+y2center(g);
    rightpolymer(g) = fill(X2new, Y2new, color2(g));
    
end

for d = 1:length(xecenter);
    X3new = X3+xecenter(d); Y3new = Y3+yecenter(d);
    selectrons(d) = fill(X3new, Y3new, 'k');
end

for k = 1:length(xemcenter);
    X3new = X3+xemcenter(k); Y3new = Y3+yemcenter(k);
    melectrons(k) = fill(X3new, Y3new, color3(k));
end

%molecule textsvector

H1 = text(10, 5, 'H', 'fontsize', fontsizeE);
C1 = text(10, 3.5, 'C', 'fontsize', fontsizeE);
H2 = text(10, 2, 'H', 'fontsize', fontsizeE);

H3 = text(19, 5, 'H', 'fontsize', fontsizeE);
C2 = text(19, 3.5, 'C', 'fontsize', fontsizeE);
H4 = text(19, 2, 'H', 'fontsize', fontsizeE);

H5 = text(21, 5, 'H', 'fontsize', fontsizeE);
C3 = text(21, 3.5, 'C', 'fontsize', fontsizeE);
H6 = text(21, 2, 'H', 'fontsize', fontsizeE);

H7 = text(10.5, 10, 'H', 'fontsize', fontsizeD);
C4 = text(10.5, 9, 'C', 'fontsize', fontsizeD);
H8 = text(10.5, 8, 'H', 'fontsize', fontsizeD);

H9 = text(16, 10, 'H', 'fontsize', fontsizeD);
C5 = text(16, 9, 'C', 'fontsize', fontsizeD);
H10 = text(16, 8, 'H', 'fontsize', fontsizeD);

H11 = text(18, 10, 'H', 'fontsize', fontsizeD);
C6 = text(18, 9, 'C', 'fontsize', fontsizeD);
H12 = text(18, 8, 'H', 'fontsize', fontsizeD);

%Creating the Bond Line
x = [17 17.8]; y = [8.85 8.85];
plot(x, y, 'k');

handles.TD.H5 = H5; 
handles.TD.H11 = H11;
handles.TD.xemcenter = xemcenter;
handles.TD.yemcenter = yemcenter;
handles.TD.melectrons = melectrons;
handles.TD.X3 = X3; 
handles.TD.Y3 = Y3;

guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in TDanimate.
function TDanimate_Callback(hObject, eventdata, handles)

struct2var(handles.TD);
struct2var(handles.font);
set(handles.TDanimate, 'visible', 'off');

%Forming New Electrons where the Bond Used to be on the Top Right
enewxvector = [18.2 18.7];
enewyvector = [9.5 9.5];

for k = 1:length(enewxvector);
    X3new = X3+enewxvector(k);
    Y3new = Y3+enewyvector(k);
    newelectrons(k) = fill(X3new, Y3new, 'k');
end


%Creating the Vectors to move the Electrons
e2xvector = linspace(xemcenter(2), 20.8, 10); %Moving the First Radical
e2yvector = linspace(yemcenter(2), 3.2, 10);

e3xvector = linspace(xemcenter(3), xemcenter(1), 20); %Moving the Radical Bonded to H
e3yvector = linspace(yemcenter(3), 3.7, 20);

e4xvector = linspace(xemcenter(4), 20.8, 10); %Moving the Radical formerly Bonded to H
e4yvector = linspace(yemcenter(4), 3.7, 10);

e6xvector = linspace(xemcenter(6), 17.2, 10); %Moving the top right Radical
e6yvector = linspace(yemcenter(6), 9.1, 10);

ne1xvector = linspace(enewxvector(1), 11.8, 20); %Moving the newly formed electrons at top
ne1yvector = linspace(enewyvector(1), 9.2, 20);

ne2xvector = linspace(enewxvector(2), 17.6, 10);
ne2yvector = linspace(enewyvector(2), 9.1, 10);

%Creating the Vectors to move the Letters
H5xvector = linspace(21, 11.5, 20);
H5yvector = linspace(5, 3.5, 20);

H11xvector = linspace(18, 12, 20);
H11yvector = linspace(10, 9, 20);

%Creating the Coordinates of the Future Second Line
x = [17 17.8]; y = [9.1 9.1];

%Moving the first set of Electrons
for k = 1: length(H5xvector);
    delete(H5); delete(H11); delete(melectrons(3)); delete(newelectrons(1));
    H5 = text(H5xvector(k), H5yvector(k), 'H', 'fontsize', fontsizeE);
    H11 = text(H11xvector(k), H11yvector(k), 'H', 'fontsize', fontsizeD);
    melectrons(3) = fill(X3+e3xvector(k), Y3+e3yvector(k), 'r');
    newelectrons(1) = fill(X3+ne1xvector(k), Y3+ne1yvector(k), 'r');
    
    pause(0.02);

end

%Changing Colors of all the Electrons that are newly Bonded and Radicalized
set(melectrons(3), 'facecolor', 'k');
set(newelectrons(1), 'facecolor', 'k');
set(melectrons(1), 'facecolor', 'k');
set(melectrons(4), 'facecolor', 'r');
set(melectrons(5), 'facecolor', 'k');
set(newelectrons(2), 'facecolor', 'r');

%Moving the Second Set of Electrons
for k = 1:length(e6xvector);
    delete(melectrons(6)); delete(melectrons(2));
    melectrons(6) = fill(X3+e6xvector(k), Y3+e6yvector(k), 'r');
    melectrons(2) = fill(X3+e2xvector(k), Y3+e2yvector(k), 'r');
    
    pause(0.02);
end

%Moving the Final set of Electrons 
for k = 1:length(ne2xvector);
    delete(newelectrons(2)); delete(melectrons(4));
    melectrons(4) = fill(X3+e4xvector(k), Y3+e4yvector(k), 'r');
    newelectrons(2) = fill(X3+ne2xvector(k), Y3+ne2yvector(k), 'r');
    
    pause(0.02);
end

set(melectrons(2), 'facecolor', 'k');
set(melectrons(4), 'facecolor', 'k');
delete(newelectrons(2));
delete(melectrons(6));

plot(x, y, 'k');

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- This Section is for Termination by Combination ---------
% ------------------------------------------------------------
function TCstart_Callback(hObject, eventdata, handles)

cla(handles.axes1); reset(handles.axes1)
set(handles.ICTanimate, 'visible', 'off');
set(handles.DBanimation, 'visible', 'off');
set(handles.ROanimation, 'visible', 'off');
set(handles.CTanimate, 'visible', 'off');
set(handles.TDanimate, 'visible', 'off');
set(handles.TCanimate, 'visible', 'on');

struct2var(handles.font);

xlim([0, 25]); ylim([0,25]);
axis square;
r = 0.5;
N = 1000;
color1 = ['k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'r'];
color2 = ['k', 'k', 'k', 'k', 'k', 'r'];
color3 = ['r'];
theta=linspace(0,2*pi,N);
rho=ones(1,N)*r;
[X,Y] = pol2cart(theta,rho);

%left polymer circles
x1center = [6 5.1 4.2 4.5 5 6 6.9 7.7 8.7 9.6];
y1center = [14 14.5 14 13 12.1 12 11.8 12.5 12.7 13.1];

%right polymer circles
x2center = [20 21 21.1 21.4 20.8 19.8];
y2center = [15 14.8 13.8 12.8 12 12.1];

%molecule electrons
r1 = 0.2;
rho1=ones(1,N)*r1;
x3center = [10.9, 18.6];
y3center = [9.2, 7.7];
[X3, Y3] = pol2cart(theta, rho1);

hold on;

h = zeros(1, length(x1center));
n = zeros(1, length(x2center));
m = zeros(1, length(x3center));

%generating each set of polymer/electron circles
for k = 1:length(x1center);
    X1new=X+x1center(k); Y1new=Y+y1center(k);
    h(k)=fill(X1new,Y1new,color1(k));
end

for g = 1:length(x2center);
    X2new = X+x2center(g); Y2new = Y+y2center(g);
    n(g) = fill(X2new, Y2new, color2(g));
    
end

for d = 1:length(x3center);
    X3new = X3+x3center(d); Y3new = Y3+y3center(d);
    m(d) = fill(X3new, Y3new, color3);
end

%molecule textsvector
H1 = text(10,10, 'H', 'fontsize', fontsizeB);
C1 = text(10, 9, 'C', 'fontsize', fontsizeB, 'color', 'r');
H2 = text(10, 8, 'H', 'fontsize', fontsizeB);

H3 = text(19, 9, 'H', 'fontsize', fontsizeB);
C2 = text(19, 8, 'C', 'fontsize', fontsizeB, 'color', 'r');
H4 = text(19, 7, 'H', 'fontsize', fontsizeB);

handles.termination.H1 = H1; handles.termination.C1 = C1; handles.termination.H2 = H2;
handles.termination.C2 = C2;
handles.termination.X = X; handles.termination.Y = Y;
handles.termination.X3 = X3; handles.termination.Y3 = Y3;
handles.termination.X2new = X2new; handles.termination.Y2new = Y2new;
handles.termination.x1center = x1center; handles.termination.y1center = y1center;
handles.termination.x2center = x2center; handles.termination.y2center = y2center;
handles.termination.x3center = x3center; handles.termination.y3center = y3center;
handles.termination.h = h; handles.termination.n = n; handles.termination.m = m;
handles.termination.color1 = color1; handles.termination.color2 = color2;
handles.termination.color3 = color3;
guidata(hObject, handles);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture

% --- Executes on button press in TCstart.
function TCanimate_Callback(hObject, eventdata, handles)
set(handles.TCanimate, 'Visible', 'off');
struct2var(handles.termination);
struct2var(handles.font);

%vectors for moving the left-side molecules
x1vector = zeros(20, 10);
y1vector = zeros(20, 10);

for p = 1:length(x1center);
    x1vector(1:20,p) = linspace(x1center(p), x1center(p)+9.2, 20);
    y1vector(1:20,p) = linspace(y1center(p), y1center(p)-0.7, 20);
end 

Allxvector = linspace(10, 17.5, 20);
H1yvector = linspace(10, 9, 20);
C1yvector = linspace(9, 8, 20);
H2yvector = linspace(8, 7, 20);

x3vector = linspace(10.9, 18.6, 20);
y3vector = linspace(9.2, 8.2, 20);

%movement
for s = 1:length(x1vector);
    for t = 1:length(x1center);
        delete(h(t));
        
        X1new=X+x1vector(s,t); Y1new=Y+y1vector(s,t);
        h(t)=fill(X1new,Y1new,color1(t));
        
        xlim([0, 25]); ylim([0,25]);
        axis square;
    end
    delete(H1);
    H1 = text(Allxvector(s), H1yvector(s), 'H', 'fontsize', fontsizeB);
    delete(C1);
    C1 = text(Allxvector(s), C1yvector(s), 'C', 'fontsize', fontsizeB, 'color', 'r');
    delete(H2);
    H2 = text(Allxvector(s), H2yvector(s), 'H', 'fontsize', fontsizeB);
    
    delete(m(1));
    X3new = X3+x3vector(s);
    Y3new = Y3+y3vector(s);
    m(1) = fill(X3new, Y3new, color3);
    
    pause(0.02);
    
end

%Changing color of the monomer units and electrons
delete(h(10));
h(10) = fill(X1new, Y1new, 'k');
delete(n(6));
n(6) = fill(X2new, Y2new, 'k');

x3center(1) = 18.6;
y3center(1) = 8.2;

for d = 1:length(x3center);
    X3new = X3+x3center(d); Y3new = Y3+y3center(d);
    m(d) = fill(X3new, Y3new, 'k');
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


% --- Executes on button press in CGMdetail.
function CGMdetail_Callback(hObject, eventdata, handles)
struct2var(handles.font);

%Finding the Text that Belongs
stringid = cellstr('Mechanisms of Chain Growth Polymerization');
stringtext = stringfinder(stringid); %Calling External Function "stringfinder"

CGMdetail = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Chain Growth Mechanisms');
CGMdetailtext = uicontrol('style','text', 'fontsize', fontsizeB, 'fontweight', 'bold', 'horizontalalignment', 'left');
set(CGMdetailtext, 'string', stringtext);
set(CGMdetailtext, 'position', [25 50 350 300], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');


% --- Executes on button press in TDMechanism.
function TDMechanism_Callback(hObject, eventdata, handles)
struct2var(handles.font);
TDmechfig = figure('position', [100, 100, 600, 600], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Termination by Disproportionation');
axes1 = axes('position', [0.1 0.1 0.8 0.8]);
mechpic = imread('./Pictures/TDmech.png');
imshow(mechpic);
