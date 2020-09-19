function varargout = Gain_Scheduling(varargin)
% GAIN_SCHEDULING MATLAB code for Gain_Scheduling.fig
%      GAIN_SCHEDULING, by itself, creates a new GAIN_SCHEDULING or raises the existing
%      singleton*.
%
%      H = GAIN_SCHEDULING returns the handle to a new GAIN_SCHEDULING or the handle to
%      the existing singleton*.
%
%      GAIN_SCHEDULING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAIN_SCHEDULING.M with the given input arguments.
%
%      GAIN_SCHEDULING('Property','Value',...) creates a new GAIN_SCHEDULING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gain_Scheduling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gain_Scheduling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gain_Scheduling

% Last Modified by GUIDE v2.5 01-May-2017 14:37:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gain_Scheduling_OpeningFcn, ...
                   'gui_OutputFcn',  @Gain_Scheduling_OutputFcn, ...
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


% --- Executes just before Gain_Scheduling is made visible.
function Gain_Scheduling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gain_Scheduling (see VARARGIN)

% Choose default command line output for Gain_Scheduling
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points valor_WCR valor_TAU valor_ZETA
TAU=get(handles.TAU_Edit,'Value');
WCR=get(handles.WCR_Edit,'Value');
ZETA=get(handles.ZETA_Edit,'Value');
VMMAX=get(handles.Vmmax_Edit,'Value');
VMMIN=get(handles.Vmmin_Edit,'Value');
XNCMAX=get(handles.ncmax_Edit,'Value');
XNCMIN=get(handles.ncmin_Edit,'Value');
ALTMAX=get(handles.Altmax_Edit,'Value');
ALTMIN=get(handles.Altimin_Edit,'Value');
points=get(handles.points_Edit,'Value');
valor_TAU=0;
valor_WCR=0;
valor_ZETA=0;

% UIWAIT makes Gain_Scheduling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gain_Scheduling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function ncmin_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to ncmin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ncmin_Edit as text
%        str2double(get(hObject,'String')) returns contents of ncmin_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
XNCMIN=str2num(get(handles.ncmin_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function ncmin_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ncmin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ncmax_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to ncmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ncmax_Edit as text
%        str2double(get(hObject,'String')) returns contents of ncmax_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
XNCMAX=str2num(get(handles.ncmax_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function ncmax_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ncmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vmmin_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Vmmin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vmmin_Edit as text
%        str2double(get(hObject,'String')) returns contents of Vmmin_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
VMMIN=str2num(get(handles.Vmmin_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function Vmmin_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vmmin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vmmax_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Vmmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vmmax_Edit as text
%        str2double(get(hObject,'String')) returns contents of Vmmax_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
VMMAX=str2num(get(handles.Vmmax_Edit,'String'));


% --- Executes during object creation, after setting all properties.
function Vmmax_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vmmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WCR_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to WCR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WCR_Edit as text
%        str2double(get(hObject,'String')) returns contents of WCR_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
WCR=str2num(get(handles.WCR_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function WCR_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WCR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZETA_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to ZETA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZETA_Edit as text
%        str2double(get(hObject,'String')) returns contents of ZETA_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
ZETA=str2num(get(handles.ZETA_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function ZETA_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZETA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TAU_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to TAU_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TAU_Edit as text
%        str2double(get(hObject,'String')) returns contents of TAU_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
TAU=str2num(get(handles.TAU_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function TAU_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TAU_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points  WCR_mat ZETA_mat TAU_mat...
    valor_TAU valor_WCR valor_ZETA num
load Airframe.mat;
dial=msgbox('Calculating. Please wait ...');
num=0;
if valor_TAU==1 
    for i=1:3
        num=num+1;
        TAU=TAU_mat(i);
    scheduling(L, Xw, XHL, CTT, CTW, CRT, CRW, hW, hT,d,W,XCG,...
    WCR,ZETA,TAU,ALTMIN,ALTMAX,XNCMIN,XNCMAX,VMMIN,VMMAX,...
    Sw,St,Sref,Lp,SPlan,XCP_Nose,XCP_Body,XCP_Wing,points,num)
    end 
elseif valor_ZETA==1
    for i=1:3
        num=num+1;
        ZETA=ZETA_mat(i);
    scheduling(L, Xw, XHL, CTT, CTW, CRT, CRW, hW, hT,d,W,XCG,...
    WCR,ZETA,TAU,ALTMIN,ALTMAX,XNCMIN,XNCMAX,VMMIN,VMMAX,...
    Sw,St,Sref,Lp,SPlan,XCP_Nose,XCP_Body,XCP_Wing,points,num)
    end 
    elseif valor_WCR==1 
    for i=1:3
        num=num+1;
        WCR=WCR_mat(i);
    scheduling(L, Xw, XHL, CTT, CTW, CRT, CRW, hW, hT,d,W,XCG,...
    WCR,ZETA,TAU,ALTMIN,ALTMAX,XNCMIN,XNCMAX,VMMIN,VMMAX,...
    Sw,St,Sref,Lp,SPlan,XCP_Nose,XCP_Body,XCP_Wing,points,num)
    end 
else
    num=0;
scheduling(L, Xw, XHL, CTT, CTW, CRT, CRW, hW, hT,d,W,XCG,...
    WCR,ZETA,TAU,ALTMIN,ALTMAX,XNCMIN,XNCMAX,VMMIN,VMMAX,...
    Sw,St,Sref,Lp,SPlan,XCP_Nose,XCP_Body,XCP_Wing,points,num)
end
num=0;
delete(dial)
dial2=msgbox('Calculation complete.');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to continue?', ...
    'Yes',...
    'No');
switch choice
    case 'Yes'
close('Gain_Scheduling')
run('Three_Loop_Autopilot')
end


function Altimin_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Altimin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Altimin_Edit as text
%        str2double(get(hObject,'String')) returns contents of Altimin_Edit as a double
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
ALTMIN=str2num(get(handles.Altimin_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function Altimin_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Altimin_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Altmax_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Altmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Altmax_Edit as text
%        str2double(get(hObject,'String')) returns contents of Altmax_Edit as a double
global VCMIN VCMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
ALTMAX=str2num(get(handles.Altmax_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function Altmax_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Altmax_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function points_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to points_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of points_Edit as text
%        str2double(get(hObject,'String')) returns contents of points_Edit as a double
global VCMIN VCMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points
points=str2num(get(handles.points_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function points_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to points_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Check_WCR.
function Check_WCR_Callback(hObject, eventdata, handles)
% hObject    handle to Check_WCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_WCR
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points valor_TAU valor_WCR valor_ZETA WCR_mat ZETA_mat TAU_mat
valor_WCR=get(handles.Check_WCR,'Value');


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points valor_TAU valor_WCR valor_ZETA WCR_mat ZETA_mat TAU_mat
matrix=get(handles.uitable1,'data');
WCR_mat=[str2double(matrix(1,1)) str2double(matrix(2,1)) str2double(matrix(3,1))];
ZETA_mat=[str2double(matrix(1,2)) str2double(matrix(2,2)) str2double(matrix(3,2))];
TAU_mat=[str2double(matrix(1,3)) str2double(matrix(2,3)) str2double(matrix(3,3))];


% --- Executes on button press in Check_ZETA.
function Check_ZETA_Callback(hObject, eventdata, handles)
% hObject    handle to Check_ZETA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Check_ZETA
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points valor_TAU valor_WCR valor_ZETA WCR_mat ZETA_mat TAU_mat
valor_ZETA=get(handles.Check_ZETA,'Value');

% --- Executes on button press in Check_TAU.
function Check_TAU_Callback(hObject, eventdata, handles)
% hObject    handle to Check_TAU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Check_TAU
global VMMIN VMMAX XNCMIN XNCMAX ALTMIN ALTMAX TAU ZETA WCR points valor_TAU valor_WCR valor_ZETA WCR_mat ZETA_mat TAU_mat
valor_TAU=get(handles.Check_TAU,'Value');
