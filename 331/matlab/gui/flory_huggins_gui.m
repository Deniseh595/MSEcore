function varargout = flory_huggins_gui(varargin)
% FLORY_HUGGINS_GUI MATLAB code for flory_huggins_gui.fig
%      FLORY_HUGGINS_GUI, by itself, creates a new FLORY_HUGGINS_GUI or raises the existing
%      singleton*.
%
%      H = FLORY_HUGGINS_GUI returns the handle to a new FLORY_HUGGINS_GUI or the handle to
%      the existing singleton*.
%
%      FLORY_HUGGINS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLORY_HUGGINS_GUI.M with the given input arguments.
%
%      FLORY_HUGGINS_GUI('Property','Value',...) creates a new FLORY_HUGGINS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flory_huggins_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flory_huggins_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flory_huggins_gui

% Last Modified by GUIDE v2.5 30-Jan-2014 12:44:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flory_huggins_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @flory_huggins_gui_OutputFcn, ...
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


% --- Executes just before flory_huggins_gui is made visible.
function flory_huggins_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flory_huggins_gui (see VARARGIN)

% Choose default command line output for flory_huggins_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flory_huggins_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = flory_huggins_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)

cla(handles.axes1);
cla(handles.axes2);

na = str2double(get(handles.Natext, 'string'));
nb = str2double(get(handles.Nbtext, 'string'));
Xminimum = str2double(get(handles.Xmintext, 'string'));
Xmaximum = str2double(get(handles.Xmaxtext, 'string'));
set(handles.Xmintext2, 'string', Xminimum);
set(handles.Xmaxtext2, 'string', Xmaximum);

xlim(handles.axes1, [Xminimum Xmaximum]);
hold(handles.axes1, 'on');

%Calculating Chi based on phi
phi=linspace(0.001,0.999,1000);
Xcrit = str2double(get(handles.Chicritedit, 'string'));
chi = 1./(2*(1-phi)*na)+1./(2*(phi)*nb);
xXcrit = chi/Xcrit;

% fv is the expression for the free energy of mixing
fv=@(phi) phi.*log(phi)/nb+(1-phi).*log(1-phi)./na+chi.*phi.*(1-phi);
%mua and  mub are the chemical potentials of A and B
mua=@(phi) log(1-phi)+phi*(1-na/nb)+chi*na*phi.^2; 
mub=@(phi) log(phi)+(1-phi)*(1-nb/na)+chi*nb*(1-phi)^2;

% now write the function that is equal to zero when the A and B chemical
% potentials are equal to one another for phi=phi(1) and phi=phi(2)

ftosolve=@(phi) [mua(phi(1))-mua(phi(2));
    mub(phi(1))-mub(phi(2))];

plot(handles.axes1, phi,fv(phi));
xlabel(handles.axes1, '\phi_{b}', 'fontsize', 14)
ylabel(handles.axes1, 'G_{v}V_{0}/RT', 'fontsize', 14)

% start with a guess for the equilibrium volume fractions
phiguess = [0.2; 0.8];     % Make a starting guess at the equilibrium compositions
[phicalc,fval] = fsolve(ftosolve,phiguess);  % Call solver 

% now we add the tangent line
slope=(fv(phicalc(2))-fv(phicalc(1)))/(phicalc(2)-phicalc(1));
intercept=fv(phicalc(1))-slope*phicalc(1);
tangentline=intercept+slope.*phi;
plot(handles.axes1, phi,tangentline,'r')

% This section plots on the Second Curve with phiB = phi vs. chi/chicrit
plot(handles.axes2, phi, xXcrit);
ylabel(handles.axes2, '\chi/\chi_{Crit}', 'fontsize', 14);
xlabel(handles.axes2, '\phi_{b}', 'fontsize', 14);

hold off
