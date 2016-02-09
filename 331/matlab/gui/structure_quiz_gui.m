function varargout = structure_quiz_gui(varargin)
% STRUCTURE_QUIZ_GUI MATLAB code for structure_quiz_gui.fig
%      STRUCTURE_QUIZ_GUI, by itself, creates a new STRUCTURE_QUIZ_GUI or raises the existing
%      singleton*.
%
%      H = STRUCTURE_QUIZ_GUI returns the handle to a new STRUCTURE_QUIZ_GUI or the handle to
%      the existing singleton*.
%
%      STRUCTURE_QUIZ_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURE_QUIZ_GUI.M with the given input arguments.
%
%      STRUCTURE_QUIZ_GUI('Property','Value',...) creates a new STRUCTURE_QUIZ_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structure_quiz_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structure_quiz_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structure_quiz_gui

% Last Modified by GUIDE v2.5 09-Oct-2013 11:31:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @structure_quiz_gui_OpeningFcn, ...
    'gui_OutputFcn',  @structure_quiz_gui_OutputFcn, ...
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


% --- Executes just before structure_quiz_gui is made visible.
function structure_quiz_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structure_quiz_gui (see VARARGIN)

% Choose default command line output for structure_quiz_gui

fontsizeA = getappdata(0, 'fontsizeA');

handles.font.fontsizeA = fontsizeA;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structure_quiz_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structure_quiz_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)

polymermatrix = randperm(19);
counter = 0;

handles.structurequiz.polymermatrix = polymermatrix;
handles.structurequiz.counter = counter;
guidata(hObject,handles);

% --- Executes on button press in newpolymerbutton.
function newpolymerbutton_Callback(hObject, eventdata, handles)

if isfield(handles,'structurequiz')
    
    struct2var(handles.structurequiz);
    
    set(handles.namebox, 'string', ' ');
    set(handles.methodbox, 'string', ' ');
    cla(handles.axes1);
    cla(handles.axes2);
    set(handles.axes1, 'visible', 'off');
    set(handles.axes2, 'visible', 'off');
    
    % ----- This Section Assigns all Polymers -------
    % -----------------------------------------------
    
    Rubber = 'Cis-Polyisoprene (Natural Rubber)';
    Rubbermethod = 'Chain growth polymerization (addition to double bond)';
    Rubbermonomer = imread(['Structures/JPG Files/', 'Cis-Polyisoprene Monomer.jpg']);
    Rubberrepeat = imread(['Structures/JPG Files/', 'Cis-Polyisoprene Repeat Unit.jpg']);
    
    PE = 'Polyethylene (PE)';
    PEmethod = 'Chain growth polymerization (addition to double bond)';
    PEmonomer = imread(['Structures/JPG Files/', 'Polyethylene Monomer.jpg']);
    PErepeat = imread(['Structures/JPG Files/', 'Polyethylene Repeat Unit.jpg']);
    
    PVAc = 'Poly(vinyl acetate) (PVAc)';
    PVAcmethod = 'Chain growth polymerization (addition to double bond)';
    PVAcmonomer = imread(['Structures/JPG Files/', 'Poly(vinyl acetate) Monomer.jpg']);
    PVAcrepeat = imread(['Structures/JPG Files/', 'Poly(vinyl acetate) Repeat Unit.jpg']);
    
    PTFE = 'Polytetrafluoroethylene (PTFE)';
    PTFEmethod = 'Chain growth polymerization (addition to double bond)';
    PTFEmonomer = imread(['Structures/JPG Files/', 'Polytetrafluoroethylene Monomer.jpg']);
    PTFErepeat = imread(['Structures/JPG Files/', 'Polytetrafluoroethylene Repeat Unit.jpg']);
    
    PP = 'Polypropylene (PP)';
    PPmethod = 'Chain growth polymerization (addition to double bond)';
    PPmonomer = imread(['Structures/JPG Files/', 'Polypropylene Monomer.jpg']);
    PPrepeat = imread(['Structures/JPG Files/', 'Polypropylene Repeat Unit.jpg']);
    
    PS = 'Polystyrene (PS)';
    PSmethod = 'Chain growth polymerization (addition to double bond)';
    PSmonomer = imread(['Structures/JPG Files/', 'Polystyrene Monomer.jpg']);
    PSrepeat = imread(['Structures/JPG Files/', 'Polystyrene Repeat Unit.jpg']);
    
    PEO = 'Poly(ethylene oxide) (PEO)';
    PEOmethod = 'Ring opening polymerization of a cyclic monomer';
    PEOmonomer = imread(['Structures/JPG Files/', 'Poly(ethylene oxide) Monomer.jpg']);
    PEOrepeat = imread(['Structures/JPG Files/', 'Poly(ethylene oxide) Repeat Unit.jpg']);
    
    PDMS = 'Poly(dimethyl siloxane) (PDMS)';
    PDMSmethod = 'Oxidation of SiCl to SiOH';
    PDMSmonomer = imread(['Structures/JPG Files/', 'Poly(dimethyl siloxane) Monomer.jpg']);
    PDMSrepeat = imread(['Structures/JPG Files/', 'Poly(dimethyl siloxane) Repeat Unit.jpg']);
    
    Nylon6 = 'Polycaprolactam (Polyamide-Nylon 6)';
    Nylon6method = 'Chain growth polymerization (ring opening)';
    Nylon6monomer = imread(['Structures/JPG Files/', 'Polycaprolactam Monomer.jpg']);
    Nylon6repeat = imread(['Structures/JPG Files/', 'Polycaprolactam Repeat Unit.jpg']);
    
    PB1 = 'Polybutene-1';
    PB1method = 'Chain growth polymerization (addition to double bond)';
    PB1monomer = imread(['Structures/JPG Files/', 'Polybutene-1 Monomer.jpg']);
    PB1repeat = imread(['Structures/JPG Files/', 'Polybutene-1 Repeat Unit.jpg']);
    
    PVC = 'Poly(vinyl chloride) (PVC)';
    PVCmethod = 'Chain growth polymerization (addition to double bond)';
    PVCmonomer = imread(['Structures/JPG Files/', 'Poly(vinyl chloride) Monomer.jpg']);
    PVCrepeat = imread(['Structures/JPG Files/', 'Poly(vinyl chloride) Repeat Unit.jpg']);
    
    PBD = 'Polybutadiene (PBD)';
    PBDmethod = 'Chain growth polymerization (addition to double bond)';
    PBDmonomer = imread(['Structures/JPG Files/', 'Polybutadiene Monomer.jpg']);
    PBDrepeat = imread(['Structures/JPG Files/', 'Polybutadiene Repeat Unit.jpg']);
    
    PCL = 'Polycaprolactone (PCL)';
    PCLmethod = 'Chain growth polymerization (ring opening)';
    PCLmonomer = imread(['Structures/JPG Files/', 'Polycaprolactone Monomer.jpg']);
    PCLrepeat = imread(['Structures/JPG Files/', 'Polycaprolactone Repeat Unit.jpg']);
    
    Neoprene = 'Trans-Polychloroprene (Neoprene Rubber)';
    Neoprenemethod = 'Chain growth polymerization (addition to double bond)';
    Neoprenemonomer = imread(['Structures/JPG Files/', 'Trans-Polychloroprene Monomer.jpg']);
    Neoprenerepeat = imread(['Structures/JPG Files/', 'Trans-Polychloroprene Repeat Unit.jpg']);
    
    PMA = 'Poly(methyl acrylate) (PMA)';
    PMAmethod = 'Chain growth polymerization (addition to double bond)';
    PMAmonomer = imread(['Structures/JPG Files/', 'Poly(methyl acrylate) Monomer.jpg']);
    PMArepeat = imread(['Structures/JPG Files/', 'Poly(methyl acrylate) Repeat Unit.jpg']);
    
    PIB = 'Poly(isobutylene) (PIB)';
    PIBmethod = 'Chain growth polymerization (addition to double bond)';
    PIBmonomer = imread(['Structures/JPG Files/', 'Polyisobutylene Monomer.jpg']);
    PIBrepeat = imread(['Structures/JPG Files/', 'Polyisobutylene Repeat Unit.jpg']);
    
    PET = 'Poly(ethylene terephthalate) (PET)';
    PETmethod = 'Step growth polymerization (with HO-CH2CH2-OH)';
    PETmonomer = imread(['Structures/JPG Files/', 'Poly(ethylene terephthalate) Monomer.jpg']);
    PETrepeat = imread(['Structures/JPG Files/', 'Poly(ethylene terephthalate) Repeat Unit.jpg']);
    
    PMMA = 'Poly(methyl methacrylate) (PMMA)';
    PMMAmethod = 'Chain growth polymerization (addition to double bond)';
    PMMAmonomer = imread(['Structures/JPG Files/', 'Poly(methyl methacrylate) Monomer.jpg']);
    PMMArepeat = imread(['Structures/JPG Files/', 'Poly(methyl methacrylate) Repeat Unit.jpg']);
    
    Kevlar = 'Kevlar';
    Kevlarmethod = 'Step growth polymerization';
    Kevlarmonomer = imread(['Structures/JPG Files/', 'Kevlar Monomer.jpg']);
    Kevlarrepeat = imread(['Structures/JPG Files/', 'Kevlar Repeat Unit.jpg']);
    
    if counter >= 0 & counter < 19;
        counter = counter+1;
    else
        counter = counter;
    end
    
    set(handles.countbox, 'string', counter);
    
    if polymermatrix(counter) == 1;
        polymer = Rubber;
        method = Rubbermethod;
        monomer = Rubbermonomer;
        repeat = Rubberrepeat;
    elseif polymermatrix(counter) == 2;
        polymer = PE;
        method = PEmethod;
        monomer = PEmonomer;
        repeat = PErepeat;
    elseif polymermatrix(counter) == 3;
        polymer = PVAc;
        method = PVAcmethod;
        monomer = PVAcmonomer;
        repeat = PVAcrepeat;
    elseif polymermatrix(counter) == 4;
        polymer = PTFE;
        method = PTFEmethod;
        monomer = PTFEmonomer;
        repeat = PTFErepeat;
    elseif polymermatrix(counter) == 5;
        polymer = PP;
        method = PPmethod;
        monomer = PPmonomer;
        repeat = PPrepeat;
    elseif polymermatrix(counter) == 6;
        polymer = PS;
        method = PSmethod;
        monomer = PSmonomer;
        repeat = PSrepeat;
    elseif polymermatrix(counter) == 7;
        polymer = PEO;
        method = PEOmethod;
        monomer = PEOmonomer;
        repeat = PEOrepeat;
    elseif polymermatrix(counter) == 8;
        polymer = PDMS;
        method = PDMSmethod;
        monomer = PDMSmonomer;
        repeat = PDMSrepeat;
    elseif polymermatrix(counter) == 9;
        polymer = Nylon6;
        method = Nylon6method;
        monomer = Nylon6monomer;
        repeat = Nylon6repeat;
    elseif polymermatrix(counter) == 10;
        polymer = PB1;
        method = PB1method;
        monomer = PB1monomer;
        repeat = PB1repeat;
    elseif polymermatrix(counter) == 11;
        polymer = PVC;
        method = PVCmethod;
        monomer = PVCmonomer;
        repeat = PVCrepeat;
    elseif polymermatrix(counter) == 12;
        polymer = PBD;
        method = PBDmethod;
        monomer = PBDmonomer;
        repeat = PBDrepeat;
    elseif polymermatrix(counter) == 13;
        polymer = PCL;
        method = PCLmethod;
        monomer = PCLmonomer;
        repeat = PCLrepeat;
    elseif polymermatrix(counter) == 14;
        polymer = Neoprene;
        method = Neoprenemethod;
        monomer = Neoprenemonomer;
        repeat = Neoprenerepeat;
    elseif polymermatrix(counter) == 15;
        polymer = PMA;
        method = PMAmethod;
        monomer = PMAmonomer;
        repeat = PMArepeat;
    elseif polymermatrix(counter) == 16;
        polymer = PIB;
        method = PIBmethod;
        monomer = PIBmonomer;
        repeat = PIBrepeat;
    elseif polymermatrix(counter) == 17;
        polymer = PET;
        method = PETmethod;
        monomer = PETmonomer;
        repeat = PETrepeat;
    elseif polymermatrix(counter) == 18;
        polymer = PMMA;
        method = PMMAmethod;
        monomer = PMMAmonomer;
        repeat = PMMArepeat;
    elseif polymermatrix(counter) == 19;
        polymer = Kevlar;
        method = Kevlarmethod;
        monomer = Kevlarmonomer;
        repeat = Kevlarrepeat;
    end
    
    handles.structurequiz.counter = counter;
    handles.structurequiz.polymer = polymer;
    handles.structurequiz.method = method;
    handles.structurequiz.monomer = monomer;
    handles.structurequiz.repeat = repeat;
    guidata(hObject,handles);
elseif ~isfield(handles,'structurequiz')
    
    fontsizeA = getappdata(0, 'fontsizeA');
    handles.font.fontsizeA = fontsizeA;
    
    warningfig = figure('position', [100, 100, 200, 200], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Warning');
    warningtext = uicontrol('style','text');
    set(warningtext, 'string', 'Please make sure to press "Start" before using the "New Polymer" button', 'fontsize', fontsizeA, 'fontweight', 'bold');
    set(warningtext, 'position', [10 100 180 50], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
    
end


% --- Executes on button press in namebutton.
function namebutton_Callback(hObject, eventdata, handles)
if isfield(handles,'structurequiz') & isfield(handles.structurequiz, 'polymer');
    
    struct2var(handles.structurequiz);
    set(handles.namebox, 'string', polymer);
    
else
    fontsizeA = getappdata(0, 'fontsizeA');
    handles.font.fontsizeA = fontsizeA;
    
    warningfig = figure('position', [100, 100, 200, 200], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Warning');
    warningtext = uicontrol('style','text');
    set(warningtext, 'string', 'Please make sure to press "Start" and "New Polymer" before using this button', 'fontsize', fontsizeA, 'fontweight', 'bold');
    set(warningtext, 'position', [10 100 180 50], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
end

% --- Executes on button press in repeatunitbutton.
function repeatunitbutton_Callback(hObject, eventdata, handles)
if isfield(handles, 'structurequiz') & isfield(handles.structurequiz, 'repeat');
    struct2var(handles.structurequiz);
    set(handles.axes1, 'visible', 'on');
    imshow(repeat, 'Parent', handles.axes1);
else
    fontsizeA = getappdata(0, 'fontsizeA');
    handles.font.fontsizeA = fontsizeA;
    
    warningfig = figure('position', [100, 100, 200, 200], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Warning');
    warningtext = uicontrol('style','text');
    set(warningtext, 'string', 'Please make sure to press "Start" and "New Polymer" before using this button', 'fontsize', fontsizeA, 'fontweight', 'bold');
    set(warningtext, 'position', [10 100 180 50], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
end

% --- Executes on button press in monomerbutton.
function monomerbutton_Callback(hObject, eventdata, handles)
if isfield(handles, 'structurequiz') & isfield(handles.structurequiz, 'monomer');
    struct2var(handles.structurequiz);
    set(handles.axes2, 'visible', 'on');
    imshow(monomer, 'Parent', handles.axes2);
else
    fontsizeA = getappdata(0, 'fontsizeA');
    handles.font.fontsizeA = fontsizeA;
    
    warningfig = figure('position', [100, 100, 200, 200], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Warning');
    warningtext = uicontrol('style','text');
    set(warningtext, 'string', 'Please make sure to press "Start" and "New Polymer" before using this button', 'fontsize', fontsizeA, 'fontweight', 'bold');
    set(warningtext, 'position', [10 100 180 50], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
end

% --- Executes on button press in methodbutton.
function methodbutton_Callback(hObject, eventdata, handles)
if isfield(handles, 'structurequiz') & isfield(handles.structurequiz, 'method');
    struct2var(handles.structurequiz);
    set(handles.methodbox, 'string', method);
else
    fontsizeA = getappdata(0, 'fontsizeA');
    handles.font.fontsizeA = fontsizeA;
    
    warningfig = figure('position', [100, 100, 200, 200], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Warning');
    warningtext = uicontrol('style','text');
    set(warningtext, 'string', 'Please make sure to press "Start" and "New Polymer" before using this button', 'fontsize', fontsizeA, 'fontweight', 'bold');
    set(warningtext, 'position', [10 100 180 50], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');
end


% --- Executes on button press in resetstructuresbutton.
function resetstructuresbutton_Callback(hObject, eventdata, handles)
set(handles.namebox, 'string', ' ');
set(handles.methodbox, 'string', ' ');

cla(handles.axes1);
cla(handles.axes2);
set(handles.axes1, 'visible', 'off');
set(handles.axes2, 'visible', 'off');

counter = 0;
polymermatrix = randperm(19);
set(handles.countbox, 'string', counter);

handles.structurequiz.counter = counter;
handles.structurequiz.polymermatrix = polymermatrix;
guidata(hObject,handles);


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


% --- Executes on button press in instructbutton.
function instructbutton_Callback(hObject, eventdata, handles)
struct2var(handles.font);
instructfig = figure('position', [100, 100, 400, 400], 'color', [0.6 1 1], 'numbertitle', 'off', 'name', 'Instructions');

instructtext = uicontrol('style','text');
set(instructtext, 'string', 'Instructions', 'fontsize', fontsizeA, 'fontweight', 'bold');
set(instructtext, 'position', [160 350 80 20], 'backgroundcolor', [0.6 1 1], 'units', 'normalized');

bodytext1 = uicontrol('style', 'text');
set(bodytext1, 'string', '- Press Start', 'fontsize', fontsizeA);
set(bodytext1, 'position', [50 300 300 20], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');

bodytext2 = uicontrol('style', 'text');
set(bodytext2, 'string', '- Press the "New Polymer" button. The structure count should increase', 'fontsize', fontsizeA);
set(bodytext2, 'position', [50 260 300 30], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');

bodytext3 = uicontrol('style', 'text');
set(bodytext3, 'string', '- Press any of the four buttons "Name", "Repeat Unit", "Monomer Unit", or "Method" to display a feature of the polymer', 'fontsize', fontsizeA);
set(bodytext3, 'position', [50 200 300 50], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');

bodytext4 = uicontrol('style', 'text');
set(bodytext4, 'string', '- When you are ready, press "New Polymer" to move on to the next polymer, there are 19 total', 'fontsize', fontsizeA);
set(bodytext4, 'position', [50 140 300 50], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');

bodytext5 = uicontrol('style', 'text');
set(bodytext5, 'string', '- When you have finished all 19 polymers, if you would like more practice, press "Reset" to randomize the polymers and start over', 'fontsize', fontsizeA);
set(bodytext5, 'position', [50 80 300 50], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');

bodytext6 = uicontrol('style', 'text');
set(bodytext6, 'string', '- Make sure to press "New Polymer" after pressing "Reset" or else you will not have a new polymer', 'fontsize', fontsizeA);
set(bodytext6, 'position', [50 20 300 50], 'backgroundcolor', [0.6 1 1],'horizontalalignment', 'left', 'units', 'normalized');
