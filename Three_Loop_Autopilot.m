function varargout = Three_Loop_Autopilot(varargin)
% THREE_LOOP_AUTOPILOT MATLAB code for Three_Loop_Autopilot.fig
%      THREE_LOOP_AUTOPILOT, by itself, creates a new THREE_LOOP_AUTOPILOT or raises the existing
%      singleton*.
%
%      H = THREE_LOOP_AUTOPILOT returns the handle to a new THREE_LOOP_AUTOPILOT or the handle to
%      the existing singleton*.
%
%      THREE_LOOP_AUTOPILOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_LOOP_AUTOPILOT.M with the given input arguments.
%
%      THREE_LOOP_AUTOPILOT('Property','Value',...) creates a new THREE_LOOP_AUTOPILOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Three_Loop_Autopilot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Three_Loop_Autopilot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Three_Loop_Autopilot

% Last Modified by GUIDE v2.5 02-May-2017 18:26:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Three_Loop_Autopilot_OpeningFcn, ...
                   'gui_OutputFcn',  @Three_Loop_Autopilot_OutputFcn, ...
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


% --- Executes just before Three_Loop_Autopilot is made visible.
function Three_Loop_Autopilot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Three_Loop_Autopilot (see VARARGIN)

% Choose default command line output for Three_Loop_Autopilot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Three_Loop_Autopilot wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global ALT VM XNC ALTMIN ALTMAX XNCMIN XNCMAX VMMIN VMMAX points TF k g num
if exist('schedule1.mat')==2
    load schedule1.mat
else
load schedule.mat
end
load Airframe.mat


ALT=linspace(ALTMIN,ALTMAX,points);
set(handles.ALT_Slider,'Max',ALTMAX);
set(handles.ALT_Slider,'Min',ALTMIN);
set(handles.ALT_Slider,'Value',ALTMIN);
set(handles.ALT_Slider,'SliderStep',[1/points 1/points]);

VM=linspace(VMMIN,VMMAX,points);
set(handles.VM_Slider,'Max',VMMAX);
set(handles.VM_Slider,'Min',VMMIN);
set(handles.VM_Slider,'Value',VMMIN);
set(handles.VM_Slider,'SliderStep',[1/points 1/points]);

XNC=linspace(XNCMIN,XNCMAX,points);
set(handles.XNC_Slider,'Max',XNCMAX);
set(handles.XNC_Slider,'Min',XNCMIN);
set(handles.XNC_Slider,'Value',XNCMIN);
set(handles.XNC_Slider,'SliderStep',[1/points 1/points]);
g=0;
k=1;

% --- Outputs from this function are returned to the command line.
function varargout = Three_Loop_Autopilot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





function ALT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to ALT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ALT_Edit as text
%        str2double(get(hObject,'String')) returns contents of ALT_Edit as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin k g
ALT_fin=str2double(get(handles.ALT_Edit,'String'));
max_ALT=get(handles.ALT_Slider,'Max');
if(ALT_fin>max_ALT)
    ALT_fin=max_ALT;
    set(handles.ALT_Edit,'String',num2str(max_ALT));
    set(handles.ALT_Slider,'Value',max_ALT);
elseif (ALT_fin<max_ALT)
    ff=find(ALT==ALT_fin);
        if isempty(ff)
            if k==1
            a=find(ALT<ALT_fin,1,'last');
            b=find(ALT>ALT_fin,1,'first');
                if abs(ALT(a)-ALT_fin)<abs(ALT(b)-ALT_fin) 
                    ALT_fin=ALT(a);
                    set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
                    set(handles.ALT_Slider,'Value',ALT_fin);
                else
                     ALT_fin=ALT(b);
                    set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
                    set(handles.ALT_Slider,'Value',ALT_fin);
                end
             elseif k==2
        ALT_fin=str2num(get(handles.ALT_Edit,'String'));
        set(handles.ALT_Edit,'String',num2str(ALT_fin));
            end
        else
        ALT_fin=ALT(ff);
        set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
        set(handles.ALT_Slider,'Value',ALT_fin);
    end
end
 

% --- Executes during object creation, after setting all properties.
function ALT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ALT_Edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WACT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to WACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WACT_Edit as text
%        str2double(get(hObject,'String')) returns contents of WACT_Edit as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
WACT=str2num(get(handles.WACT_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function WACT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TAUACT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to TAUACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TAUACT_Edit as text
%        str2double(get(hObject,'String')) returns contents of TAUACT_Edit as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
TAUACT=str2num(get(handles.TAUACT_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function TAUACT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TAUACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZETACT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to ZETACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZETACT_Edit as text
%        str2double(get(hObject,'String')) returns contents of ZETACT_Edit as a double
global  VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
ZETAACT=str2num(get(handles.ZETACT_Edit,'String'));

% --- Executes during object creation, after setting all properties.
function ZETACT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZETACT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to ALT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ALT_Edit as text
%        str2double(get(hObject,'String')) returns contents of ALT_Edit as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ALT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function XNC_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to XNC_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
% set(handles.VM_Edit,'String',num2str(get(handles.VM_Slider,'Value')));
XNC_fin=get(handles.XNC_Slider,'Value');
 ff=find(XNC==XNC_fin);
        if isempty(ff)
            a=find(XNC<XNC_fin,1,'last');
            b=find(XNC>XNC_fin,1,'first');
                if abs(XNC(a)-XNC_fin)<abs(XNC(b)-XNC_fin) 
                    XNC_fin=XNC(a);
                    set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
                    set(handles.XNC_Slider,'Value',XNC_fin);
                else
                     XNC_fin=XNC(b);
                    set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
                    set(handles.XNC_Slider,'Value',XNC_fin);
                end
        else
        XNC_fin=XNC(ff);
        set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
        set(handles.XNC_Slider,'Value',XNC_fin);
    end

% --- Executes during object creation, after setting all properties.
function XNC_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XNC_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function XNC_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to XNC_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XNC_Edit as text
%        str2double(get(hObject,'String')) returns contents of XNC_Edit as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin k g  
XNC_fin=str2double(get(handles.XNC_Edit,'String'));
max_XNC=get(handles.XNC_Slider,'Max');
if(XNC_fin>max_XNC)
    XNC_fin=max_XNC;
    set(handles.XNC_Edit,'String',num2str(max_XNC));
    set(handles.XNC_Slider,'Value',max_XNC);
elseif (XNC_fin<max_XNC)
    ff=find(XNC==XNC_fin);
        if isempty(ff)
            if k==1
            a=find(XNC<XNC_fin,1,'last');
            b=find(XNC>XNC_fin,1,'first');
                if abs(XNC(a)-XNC_fin)<abs(XNC(b)-XNC_fin) 
                    XNC_fin=XNC(a);
                    set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
                    set(handles.XNC_Slider,'Value',XNC_fin);
                else
                     XNC_fin=XNC(b);
                    set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
                    set(handles.XNC_Slider,'Value',XNC_fin);
                end
         elseif k==2
        XNC_fin=str2num(get(handles.XNC_Edit,'String'));
        set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
            end
        else
        XNC_fin=XNC(ff);
        set(handles.XNC_Edit,'String',num2str(XNC_fin,'%.1f'));
        set(handles.XNC_Slider,'Value',XNC_fin);
    end
end

% --- Executes during object creation, after setting all properties.
function XNC_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XNC_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VM_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to VM_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VM_Edit as text
%        str2double(get(hObject,'String')) returns contents of VM_Edit as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin k g
VM_fin=str2double(get(handles.VM_Edit,'String'));
max_VM=get(handles.VM_Slider,'Max');
if(VM_fin>max_VM)
    VM_fin=max_VM;
    set(handles.VM_Edit,'String',num2str(max_VM));
    set(handles.VM_Slider,'Value',max_VM);
elseif (VM_fin<max_VM)
    ff=find(VM==VM_fin);
        if isempty(ff) 
            if k==1
            a=find(VM<VM_fin,1,'last');
            b=find(VM>VM_fin,1,'first');
                if abs(VM(a)-VM_fin)<abs(VM(b)-VM_fin) 
                    VM_fin=VM(a);
                    set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
                    set(handles.VM_Slider,'Value',VM_fin);
                else
                     VM_fin=VM(b);
                    set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
                    set(handles.VM_Slider,'Value',VM_fin);
                end
        elseif k==2
        VM_fin=str2num(get(handles.VM_Edit,'String'));
        set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
            end
        else
        VM_fin=VM(ff);
        set(handles.VM_Edit,'String',num2str(VM_fin));
        set(handles.VM_Slider,'Value',VM_fin);
    end
end
 
 
% --- Executes during object creation, after setting all properties.
function VM_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VM_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function VM_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to VM_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
% set(handles.VM_Edit,'String',num2str(get(handles.VM_Slider,'Value')));
VM_fin=get(handles.VM_Slider,'Value');
 ff=find(VM==VM_fin);
        if isempty(ff)
            a=find(VM<VM_fin,1,'last');
            b=find(VM>VM_fin,1,'first');
                if abs(VM(a)-VM_fin)<abs(VM(b)-VM_fin) 
                    VM_fin=VM(a);
                    set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
                    set(handles.VM_Slider,'Value',VM_fin);
                else
                     VM_fin=VM(b);
                    set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
                    set(handles.VM_Slider,'Value',VM_fin);
                end
        else
        VM_fin=VM(ff);
        set(handles.VM_Edit,'String',num2str(VM_fin,'%.1f'));
        set(handles.VM_Slider,'Value',VM_fin);
    end

 


% --- Executes during object creation, after setting all properties.
function VM_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VM_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ALT_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to ALT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin 
% set(handles.VM_Edit,'String',num2str(get(handles.VM_Slider,'Value')));
ALT_fin=get(handles.ALT_Slider,'Value');
 ff=find(ALT==ALT_fin);
        if isempty(ff)
            a=find(ALT<ALT_fin,1,'last');
            b=find(ALT>ALT_fin,1,'first');
                if abs(ALT(a)-ALT_fin)<abs(ALT(b)-ALT_fin) 
                    ALT_fin=ALT(a);
                    set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
                    set(handles.ALT_Slider,'Value',ALT_fin);
                else
                     ALT_fin=ALT(b);
                    set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
                    set(handles.ALT_Slider,'Value',ALT_fin);
                end
        else
        ALT_fin=ALT(ff);
        set(handles.ALT_Edit,'String',num2str(ALT_fin,'%.1f'));
        set(handles.ALT_Slider,'Value',ALT_fin);
    end



% --- Executes during object creation, after setting all properties.
function ALT_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ALT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin k g TF num1 num2


load Airframe.mat;

if exist('schedule1.mat')==2
load schedule1.mat;
else
   load schedule.mat;
end

cla(handles.axes6);
cla(handles.axes8);
cla(handles.axes7);
dial=msgbox('Calculating.Please wait...');


[XKA XKDC WI XKR num1]=TLA_3(VM,ALT,XNC,VM_fin,ALT_fin,XNC_fin,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,WACT,ZETAACT,...
    TAUACT,WAF,ZAF,TAU,ZETA,WCR,TF,k,g,handles);

delete(dial)
%num1: es 1 si se cumple que solo se estudia un caso. es [] si no.
%num2: es al contrario. 1 si se estudia un barrido, [] cuando no.
hold off
if g==0 && num1==0
set(handles.KDC_Edit,'String',num2str(XKDC));
set(handles.KA_Edit,'String',num2str(XKA));
set(handles.WI_Edit,'String',num2str(WI));
set(handles.KR_Edit,'String',num2str(XKR));
set(handles.axes6,'YColor',[1 1 1]);
set(handles.axes6,'XColor',[1 1 1]);
else
set(handles.KDC_Edit,'String','-');
set(handles.KA_Edit,'String','-');
set(handles.WI_Edit,'String','-');
set(handles.KR_Edit,'String','-'); 
end

function KDC_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to KDC_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KDC_Edit as text
%        str2double(get(hObject,'String')) returns contents of KDC_Edit as a double


% --- Executes during object creation, after setting all properties.
function KDC_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KDC_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KA_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to KA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KA_Edit as text
%        str2double(get(hObject,'String')) returns contents of KA_Edit as a double


% --- Executes during object creation, after setting all properties.
function KA_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WI_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to WI_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WI_Edit as text
%        str2double(get(hObject,'String')) returns contents of WI_Edit as a double


% --- Executes during object creation, after setting all properties.
function WI_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WI_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KR_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to KR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KR_Edit as text
%        str2double(get(hObject,'String')) returns contents of KR_Edit as a double


% --- Executes during object creation, after setting all properties.
function KR_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TF_Callback(hObject, eventdata, handles)
% hObject    handle to TF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TF as text
%        str2double(get(hObject,'String')) returns contents of TF as a double
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin TF
TF=str2num(get(handles.TF,'String'));


% --- Executes during object creation, after setting all properties.
function TF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in Method.
function Method_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Method 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin TF k g
val=get(hObject,'String');
switch val
    case 'Nearest'
        k=1;
    case 'Interpolation'
        k=2;
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VM ALT XNC ZETAACT WACT TAUACT ALT_fin VM_fin XNC_fin TF k g
val=get(hObject,'String');
switch val
    case 'Frequency (rad/s)'
        g=1;
    case 'Damping (-)'
        g=2;
    case 'Delay (s)'
        g=3;
    case 'Alt (ft)'
        g=4;
    case 'VM (ft/s)'
        g=5;
    case 'nc (G)'
        g=6;
    case 'None'
        g=0;
end


% --- Executes when uibuttongroup1 is resized.
function uibuttongroup1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to continue?', ...
    'Yes',...
    'No');
switch choice
    case 'Yes'
close('Three_Loop_Autopilot')
run('Gain_Scheduling')
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to exit?', ...
    'Yes',...
    'No');
switch choice
    case 'Yes'
close('Three_Loop_Autopilot')
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes8


% --- Executes during object deletion, before destroying properties.
function axes8_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
