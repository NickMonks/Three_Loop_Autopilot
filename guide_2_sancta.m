function varargout = guide_2_sancta(varargin)
% GUIDE_2_SANCTA MATLAB code for guide_2_sancta.fig
%      GUIDE_2_SANCTA, by itself, creates a new GUIDE_2_SANCTA or raises the existing
%      singleton*.
%
%      H = GUIDE_2_SANCTA returns the handle to a new GUIDE_2_SANCTA or the handle to
%      the existing singleton*.
%
%      GUIDE_2_SANCTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_2_SANCTA.M with the given input arguments.
%
%      GUIDE_2_SANCTA('Property','Value',...) creates a new GUIDE_2_SANCTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_2_sancta_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_2_sancta_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_2_sancta

% Last Modified by GUIDE v2.5 13-Apr-2017 19:33:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_2_sancta_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_2_sancta_OutputFcn, ...
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


% --- Executes just before guide_2_sancta is made visible.
function guide_2_sancta_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_2_sancta (see VARARGIN)

% Choose default command line output for guide_2_sancta
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG W
handles.output = hObject;
movegui('center');
%Se incializa el plot al principio para evitar tener que apretar botón

set(handles.L_Edit,'String',num2str(get(handles.L_Slider,'Value')));
L=get(handles.L_Slider,'Value');

set(handles.Lp_Edit,'String',num2str(get(handles.Lp_Slider,'Value')));
Lp=get(handles.Lp_Slider,'Value');

set(handles.d_Edit,'String',num2str(get(handles.d_Slider,'Value')));
d=get(handles.d_Slider,'Value');

set(handles.CRT_Edit,'String',num2str(get(handles.CRT_Slider,'Value')));
CRT=get(handles.CRT_Slider,'Value');

set(handles.CRW_Edit,'String',num2str(get(handles.CRW_Slider,'Value')));
CRW=get(handles.CRW_Slider,'Value');

set(handles.CTW_Edit,'String',num2str(get(handles.CTW_Slider,'Value')));
CTW=get(handles.CTW_Slider,'Value');

set(handles.CTT_Edit,'String',num2str(get(handles.CTT_Slider,'Value')));
CTT=get(handles.CTT_Slider,'Value');

set(handles.Xw_Edit,'String',num2str(get(handles.Xw_Slider,'Value')));
Xw=get(handles.Xw_Slider,'Value');

set(handles.hT_Edit,'String',num2str(get(handles.hT_Slider,'Value')));
hT=get(handles.hT_Slider,'Value');

set(handles.hW_Edit,'String',num2str(get(handles.hW_Slider,'Value')));
hW=get(handles.hW_Slider,'Value');

set(handles.XHL_Edit,'String',num2str(get(handles.XHL_Slider,'Value')));
XHL=get(handles.XHL_Slider,'Value');

set(handles.XCG_Edit,'String',num2str(get(handles.XCG_Slider,'Value')));
XCG=get(handles.XCG_Slider,'Value');

set(handles.W_Edit,'String',num2str(1000));

W=500;

cond_plot=(1:11);
hold off
axes(handles.axes1);
missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, 0,XHL,XCG);
% axes(handles.axes2);
% imshow('Logoupv.png');
clc;


% UIWAIT makes guide_2_sancta wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_2_sancta_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


% --- Executes on slider movement.
function L_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to L_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG

set(handles.L_Edit,'String',num2str(get(handles.L_Slider,'Value')));
L=get(handles.L_Slider,'Value');
condplot=cond_plot(1);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT&& XHL>(L-CRT)&& XHL<L
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
 elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end





% --- Executes during object creation, after setting all properties.
function L_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function L_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to L_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L_Edit as text
%        str2double(get(hObject,'String')) returns contents of L_Edit as a
%        double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
L=str2double(get(handles.L_Edit,'String'));
max_L=get(handles.L_Slider,'Max');
if(L>max_L)
    L=max_L;
    set(handles.L_Edit,'String',num2str(max_L));
end
set(handles.L_Slider,'Value',L);
condplot=cond_plot(1);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT&& XHL>(L-CRT)&& XHL<L
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
 elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end
% --- Executes during object creation, after setting all properties.
function L_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Lp_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Lp_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.Lp_Edit,'String',num2str(get(handles.Lp_Slider,'Value')));
Lp=get(handles.Lp_Slider,'Value');
condplot=cond_plot(2);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT)
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')

end




% --- Executes during object creation, after setting all properties.
function Lp_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lp_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function d_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to d_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.d_Edit,'String',num2str(get(handles.d_Slider,'Value')));
d=get(handles.d_Slider,'Value');
condplot=cond_plot(3);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT)
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function d_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CTW_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to CTW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.CTW_Edit,'String',num2str(get(handles.CTW_Slider,'Value')));
CTW=get(handles.CTW_Slider,'Value');
condplot=cond_plot(4);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end


% --- Executes during object creation, after setting all properties.
function CTW_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CRW_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to CRW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.CRW_Edit,'String',num2str(get(handles.CRW_Slider,'Value')));
CRW=get(handles.CRW_Slider,'Value');
condplot=cond_plot(5);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function CRW_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CRW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Xw_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Xw_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.Xw_Edit,'String',num2str(get(handles.Xw_Slider,'Value')));
Xw=get(handles.Xw_Slider,'Value');
condplot=cond_plot(6);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end


% --- Executes during object creation, after setting all properties.
function Xw_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xw_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function hW_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to hW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.hW_Edit,'String',num2str(get(handles.hW_Slider,'Value')));
hW=get(handles.hW_Slider,'Value');
condplot=cond_plot(7);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function hW_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hW_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CTT_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to CTT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.CTT_Edit,'String',num2str(get(handles.CTT_Slider,'Value')));
CTT=get(handles.CTT_Slider,'Value');
condplot=cond_plot(8);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function CTT_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CRT_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to CRT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.CRT_Edit,'String',num2str(get(handles.CRT_Slider,'Value')));
CRT=get(handles.CRT_Slider,'Value');
condplot=cond_plot(9);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT&& XHL>(L-CRT)&& XHL<L
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function CRT_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CRT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function CTW_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to CTW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CTW_Edit as text
%        str2double(get(hObject,'String')) returns contents of CTW_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
CTW=str2double(get(handles.CTW_Edit,'String'));
max_CTW=get(handles.CTW_Slider,'Max');
if(CTW>max_CTW)
    CTW=max_CTW;
    set(handles.CTW_Edit,'String',num2str(max_CTW));
end
set(handles.CTW_Slider,'Value',CTW);
condplot=cond_plot(4);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function CTW_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xw_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Xw_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xw_Edit as text
%        str2double(get(hObject,'String')) returns contents of Xw_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
Xw=str2double(get(handles.Xw_Edit,'String'));
max_Xw=get(handles.Xw_Slider,'Max');
if(Xw>max_Xw)
    Xw=max_Xw;
    set(handles.Xw_Edit,'String',num2str(max_Xw));
end
set(handles.Xw_Slider,'Value',Xw);

condplot=cond_plot(6);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end


% --- Executes during object creation, after setting all properties.
function Xw_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xw_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CRT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to CRT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CRT_Edit as text
%        str2double(get(hObject,'String')) returns contents of CRT_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
CRT=str2double(get(handles.CRT_Edit,'String'));
max_CRT=get(handles.CRT_Slider,'Max');
if(CRT>max_CRT)
    CRT=max_CRT;
    set(handles.CRT_Edit,'String',num2str(max_CRT));
end
set(handles.CRT_Slider,'Value',CRT);
condplot=cond_plot(9);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT&& XHL>(L-CRT)&& XHL<L
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function CRT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CRT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CTT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to CTT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CTT_Edit as text
%        str2double(get(hObject,'String')) returns contents of CTT_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
CTT=str2double(get(handles.CTT_Edit,'String'));
max_CTT=get(handles.CTT_Slider,'Max');

if(CTT>max_CTT)
    CTT=max_CTT;
    set(handles.CTT_Edit,'String',num2str(max_CTT));
end
set(handles.CTT_Slider,'Value',CTT);
condplot=cond_plot(8);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end



% --- Executes during object creation, after setting all properties.
function CTT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hW_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to hW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hW_Edit as text
%        str2double(get(hObject,'String')) returns contents of hW_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG

hW=str2double(get(handles.hW_Edit,'String'));
max_hW=get(handles.hW_Slider,'Max');
if(hW>max_hW)
    hW=max_hW;
    set(handles.hW_Edit,'String',num2str(max_hW));
end
set(handles.hW_Slider,'Value',hW);
condplot=cond_plot(7);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function hW_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Lp_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Lp_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lp_Edit as text
%        str2double(get(hObject,'String')) returns contents of Lp_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
Lp=str2double(get(handles.Lp_Edit,'String'));
max_Lp=get(handles.Lp_Slider,'Max');
if(Lp>max_Lp)
    Lp=max_Lp;
    set(handles.Lp_Edit,'String',num2str(max_Lp));
end
set(handles.Lp_Slider,'Value',Lp);
condplot=cond_plot(2);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function Lp_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lp_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to d_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_Edit as text
%        str2double(get(hObject,'String')) returns contents of d_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
d=str2double(get(handles.d_Edit,'String'));
max_d=get(handles.d_Slider,'Max');
if(d>max_d)
    d=max_d;
    set(handles.d_Edit,'String',num2str(max_d));
end
set(handles.d_Slider,'Value',d);
condplot=cond_plot(3);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function d_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CRW_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to CRW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CRW_Edit as text
%        str2double(get(hObject,'String')) returns contents of CRW_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
CRW=str2double(get(handles.CRW_Edit,'String'));
max_CRW=get(handles.CRW_Slider,'Max');
if(CRW>max_CRW)
    CRW=max_CRW;
    set(handles.CRW_Edit,'String',num2str(max_CRW));
end
set(handles.CRW_Slider,'Value',CRW);
condplot=cond_plot(5);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end


% --- Executes during object creation, after setting all properties.
function CRW_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CRW_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function hT_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to hT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
set(handles.hT_Edit,'String',num2str(get(handles.hT_Slider,'Value')));
hT=get(handles.hT_Slider,'Value');
condplot=cond_plot(10);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end



% --- Executes during object creation, after setting all properties.
function hT_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hT_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function hT_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to hT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hT_Edit as text
%        str2double(get(hObject,'String')) returns contents of hT_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
hT=str2double(get(handles.hT_Edit,'String'));
max_hT=get(handles.hT_Slider,'Max');
if(hT>max_hT)
    hT=max_hT;
    set(handles.hT_Edit,'String',num2str(max_hT));
end
set(handles.hT_Slider,'Value',hT);

condplot=cond_plot(10);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    axes(handles.axes1);
    hold off
missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
else 
    warndlg('Atención. No se pueden tener valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function hT_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hT_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Scheduling_open.
function Scheduling_open_Callback(hObject, eventdata, handles)
% hObject    handle to Scheduling_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to continue?', ...
    'Yes',...
    'No');
switch choice
    case 'Yes'
close('guide_2_sancta')
run('Gain_Scheduling')
end


% --- Executes on button press in save_geometry.
function save_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to save_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG W
   [Sref Sw St SPlan AN AB XCP_Nose XCP_Body XCP_Wing] = ...
       missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d,0,XHL,XCG)
save Airframe.mat Sref Sw St SPlan XCG XCP_Nose XCP_Body XCP_Wing ...
    XHL L Lp d CRT CRW CTT CTW Xw hT hW W



function XHL_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to XHL_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XHL_Edit as text
%        str2double(get(hObject,'String')) returns contents of XHL_Edit as a double

global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
XHL=str2double(get(handles.XHL_Edit,'String'));
max_XHL=get(handles.L_Slider,'Value');
if(XHL>max_XHL)
    XHL=max_XHL;
    set(handles.XHL_Edit,'String',num2str(max_XHL));
end
set(handles.XHL_Slider,'Value',XHL);
condplot=cond_plot(11);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL >0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT && XHL>(L-CRT)
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function XHL_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XHL_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function XCG_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to XCG_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG 
set(handles.XCG_Edit,'String',num2str(get(handles.XCG_Slider,'Value')));
XCG=get(handles.XCG_Slider,'Value');
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, 0,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function XCG_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XCG_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function XHL_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to XHL_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG 
set(handles.XHL_Edit,'String',num2str(get(handles.XHL_Slider,'Value')));
XHL=get(handles.XHL_Slider,'Value');
condplot=cond_plot(11);
hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL>0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT&& XHL>(L-CRT)&& XHL<L
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d, condplot,XHL,XCG);
    elseif (XHL)>(L) 
       warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Vuelve al valor anterior')   
    elseif XHL<(L-CRT)
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Aumentar el valor de XHL o reducir CRT y L')
    else
        warndlg('Atención. No es posible gráficar el misil con estas dimensiones. Modificar la posición de XHL o L')
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end


% --- Executes during object creation, after setting all properties.
function XHL_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XHL_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function XCG_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to XCG_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XCG_Edit as text
%        str2double(get(hObject,'String')) returns contents of XCG_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG
XCG=str2double(get(handles.XCG_Edit,'String'));
max_XCG=get(handles.L_Slider,'Value');
if(XCG>max_XCG)
    XCG=max_XCG/2;
    set(handles.XCG_Edit,'String',num2str(max_XCG));
end
set(handles.XCG_Slider,'Value',XCG);

hold off
if L>0 && Xw > 0 && Lp>0 && CRT>0 && CRW>0 && hW>0 && hT>0 && d>0 && XHL >0 && XCG >0
    if (L-Xw-Lp)>(CRW+CRT) && CRW>CTW && CRT>CTT
    axes(handles.axes1);
    hold off
    missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hW, hT,d,0,XHL,XCG);
    else 
      warndlg('Atención. No es posible gráficar el misil con estas dimensiones')  
    end
else
    warndlg('Atención. No se permiten valores nulos.')
end

% --- Executes during object creation, after setting all properties.
function XCG_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XCG_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function W_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to W_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W_Edit as text
%        str2double(get(hObject,'String')) returns contents of W_Edit as a double
global L Lp d CRT CRW CTT CTW Xw hT hW cond_plot XHL XCG W
W=str2num(get(handles.W_Edit,'String'));



% --- Executes during object creation, after setting all properties.
function W_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
