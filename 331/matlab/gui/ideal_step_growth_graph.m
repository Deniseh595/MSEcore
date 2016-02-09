function varargout = ideal_step_growth_graph(varargin)
% IDEAL_STEP_GROWTH_GRAPH MATLAB code for ideal_step_growth_graph.fig
%      IDEAL_STEP_GROWTH_GRAPH, by itself, creates a new IDEAL_STEP_GROWTH_GRAPH or raises the existing
%      singleton*.
%
%      H = IDEAL_STEP_GROWTH_GRAPH returns the handle to a new IDEAL_STEP_GROWTH_GRAPH or the handle to
%      the existing singleton*.
%
%      IDEAL_STEP_GROWTH_GRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDEAL_STEP_GROWTH_GRAPH.M with the given input arguments.
%
%      IDEAL_STEP_GROWTH_GRAPH('Property','Value',...) creates a new IDEAL_STEP_GROWTH_GRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ideal_step_growth_graph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ideal_step_growth_graph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ideal_step_growth_graph

% Last Modified by GUIDE v2.5 01-Aug-2013 14:08:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ideal_step_growth_graph_OpeningFcn, ...
                   'gui_OutputFcn',  @ideal_step_growth_graph_OutputFcn, ...
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


% --- Executes just before ideal_step_growth_graph is made visible.
function ideal_step_growth_graph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ideal_step_growth_graph (see VARARGIN)

% Choose default command line output for ideal_step_growth_graph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ideal_step_growth_graph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ideal_step_growth_graph_OutputFcn(hObject, eventdata, handles) 
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
hold(handles.axes1, 'on');
hold(handles.axes2, 'on');

p = str2double(get(handles.pedit, 'string'));
N_n = 1/(2*(1-p));
N_w = 1/2*(1+p)/(1-p);

xmax1 = 3*N_w;
xmax2 = 3*N_w;
xmin1 = str2double(get(handles.xmin1edit, 'string'));
xmin2 = str2double(get(handles.xmin2edit, 'string'));
set(handles.xmax1edit, 'string', xmax1);
set(handles.xmax2edit, 'string', xmax2);
set(handles.Nnedit, 'string', N_n);
set(handles.Nwedit, 'string', N_w);

xlim(handles.axes1, [xmin1 xmax1]);
xlim(handles.axes2, [xmin2 xmax2]);

%Plotting the actual graphs
N1 = linspace(xmin1, xmax1, 10000);
N2 = linspace(xmin2, xmax2, 10000);

n_N = (1-p)*p.^(2*N1-1);
w_N = N2*(1-p).*p.^(2*N2-1);

plot(handles.axes1, N1, n_N);
plot(handles.axes2, N2, w_N);

%Plotting the Vertical Lines
maxn = max(n_N);
maxw = max(w_N);

Nnline = linspace(0, maxn, 1000);
Nwline = linspace(0, maxw, 1000);

Nnx = zeros(1, 1000);
Nwx = zeros(1, 1000);

for k = 1:length(Nnx);
    Nnx(k) = N_n;
    Nwx(k) = N_w;
end

plot(handles.axes1, Nnx, Nnline, 'r');
plot(handles.axes1, Nwx, Nnline, 'r');
plot(handles.axes2, Nnx, Nwline, 'r');
plot(handles.axes2, Nwx, Nwline, 'r');

ylabel(handles.axes1, 'n_{N}', 'fontsize', 12);
ylabel(handles.axes2, 'w_{N}', 'fontsize', 12);
xlabel(handles.axes1, 'N', 'fontsize', 12);
xlabel(handles.axes2, 'N', 'fontsize', 12);

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture
