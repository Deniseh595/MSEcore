function varargout = soft_materials_gui2(varargin)
% SOFT_MATERIALS_GUI2 MATLAB code for soft_materials_gui2.fig
%      SOFT_MATERIALS_GUI2, by itself, creates a new SOFT_MATERIALS_GUI2 or raises the existing
%      singleton*.
%
%      H = SOFT_MATERIALS_GUI2 returns the handle to a new SOFT_MATERIALS_GUI2 or the handle to
%      the existing singleton*.
%
%      SOFT_MATERIALS_GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFT_MATERIALS_GUI2.M with the given input arguments.
%
%      SOFT_MATERIALS_GUI2('Property','Value',...) creates a new SOFT_MATERIALS_GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before soft_materials_gui2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to soft_materials_gui2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help soft_materials_gui2

% Last Modified by GUIDE v2.5 19-Aug-2013 15:40:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @soft_materials_gui2_OpeningFcn, ...
                   'gui_OutputFcn',  @soft_materials_gui2_OutputFcn, ...
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


% --- Executes just before soft_materials_gui2 is made visible.
function soft_materials_gui2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to soft_materials_gui2 (see VARARGIN)

% Choose default command line output for soft_materials_gui2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes soft_materials_gui2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = soft_materials_gui2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in cahnhilliard.
function cahnhilliard_Callback(hObject, eventdata, handles)

%clear
format long 

% spatial dimensions
N = 128;  M = 128;  % originally 128x128
delx = 1/(M-1);
delx2 = delx^2;
x = (0:delx:1)'; %Creates Vector from 0-1 with length M-1

% graphics parameters
visual_update = 10;
type_update = 10;

% time parameters
t = 0;
delt = 0.00005;
ntmax = 250;

% CH parameters
epsilon = 0.01;
eps2 = epsilon^2;

% time-step parameter used in Eyre's scheme
a = 2;

% update parameters
lam1 = delt/delx2;
lam2 = eps2*lam1/delx2;

% unscaled eigenvalues of the laplacian (nuemann bc)
Leig  = (((2*cos(pi*(0:N-1)'/(N-1)))-2)*ones(1,M)) + ...
         (ones(N,1)*((2*cos(pi*(0:M-1)/(M-1)))-2));

% scaled eigenvalues of stabilized CH update matrix
CHeig = ones(N,M) - (a*lam1*Leig) + (lam2*Leig.*Leig);

% scaled eigenvalues of the laplacian
Seig = lam1*Leig;

% random initial conditions
U = (rand(N,M)-0.5)*0.01; 
hat_U = dct2(U); 

% main loop

it = 0; j=0;
t = 0.0;
while it < ntmax 
    
  if rem(it,type_update) == 0 
      
    [it t max(max(abs(U)))];
        
  end

  if rem(it,visual_update) == 0
     
    
    subplot('position', [.5 .6 .25 .25])
    pcolor(U), shading interp, ... 
    axis('off'), axis('equal'), title('U');
    
    vhat = abs(hat_U); vhat(1,1)=0; 
    vhat = vhat/max(max(abs(vhat)));
    
    subplot('position', [.5 .25 .25 .25])
    pcolor(vhat), ...
    shading interp, axis('off'), axis('equal'),
    axis([0 M/4 0 N/4]), title('| Uhat |') 
    
    %Changing the Replay Speed
    if get(handles.faster, 'value')
    pause(0.2);
    elseif get(handles.slower, 'value')
    pause(0.8);
    else
    pause(0.8);
    end
   
    if it == 0 %on the FIRST REPETITION
      mov = moviein(ntmax/visual_update,gcf);
        
    end
    j=j+1; mov(:,j) = getframe(gcf);
        
        
  end

% Update the solution
  it = it+1; 
  t = t+delt; 
  
  % compute the shifted nonlinear term
  fU = (U.*U.*U) - ((1+a)*U);

% compute the right hand side in tranform space
  hat_rhs = hat_U + (Seig.*dct2(fU));

% compute the updated solution in tranform space
  hat_U = hat_rhs./CHeig;

% invert the cosine transform
  U = idct2(hat_U);

end

replays = str2double(get(handles.replayspeed, 'string'));

if replays < 3;
    replays = 3;
elseif replays > 12;
    replays = 12;
end

repetitions = str2double(get(handles.repetitionamount, 'string'));

movie(gcf,mov,repetitions,replays) 

% ----------This Section is for Taking Pictures if Necessary----------
% --------------------------------------------------------------------
takepicture
