function varargout = immiscible_blends_gui(varargin)
% IMMISCIBLE_BLENDS_GUI MATLAB code for immiscible_blends_gui.fig
%      IMMISCIBLE_BLENDS_GUI, by itself, creates a new IMMISCIBLE_BLENDS_GUI or raises the existing
%      singleton*.
%
%      H = IMMISCIBLE_BLENDS_GUI returns the handle to a new IMMISCIBLE_BLENDS_GUI or the handle to
%      the existing singleton*.
%
%      IMMISCIBLE_BLENDS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMMISCIBLE_BLENDS_GUI.M with the given input arguments.
%
%      IMMISCIBLE_BLENDS_GUI('Property','Value',...) creates a new IMMISCIBLE_BLENDS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before immiscible_blends_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to immiscible_blends_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help immiscible_blends_gui

% Last Modified by GUIDE v2.5 30-Jan-2014 14:02:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @immiscible_blends_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @immiscible_blends_gui_OutputFcn, ...
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


% --- Executes just before immiscible_blends_gui is made visible.
function immiscible_blends_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to immiscible_blends_gui (see VARARGIN)

% Choose default command line output for immiscible_blends_gui
axis(handles.axes1, 'square');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes immiscible_blends_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = immiscible_blends_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in immiscibleblends.
function immiscibleblends_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in immiscibleblends 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%Cases for the Button Group
switch get(eventdata.NewValue, 'Tag')
    
    case 'NCbutton'
        image = imread('./Pictures/No Copolymer added.png');
        imshow(image);
        set(handles.textbox, 'string', 'No copolymer added');
    case 'NAbutton'
        image = imread('./Pictures/No annealing treatment.png');
        imshow(image);
        set(handles.textbox, 'string', 'No annealing treatment');
    case 'SM85button'
        image = imread('./Pictures/5% SM85 added.png');
        imshow(image);
        set(handles.textbox, 'string', '5% SM85 added');
    case 'SM160button'
        image = imread('./Pictures/5% SM160 added.png');
        imshow(image);
        set(handles.textbox, 'string', '5% SM160 added');
    case 'Abutton'
        image = imread('./Pictures/Annealed for 20 minutes at 195 Celsius.png');
        imshow(image);
    otherwise
end
