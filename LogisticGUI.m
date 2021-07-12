function varargout = LogisticGUI(varargin)
% LOGISTICGUI MATLAB code for LogisticGUI.fig
%      LOGISTICGUI, by itself, creates a new LOGISTICGUI or raises the existing
%      singleton*.
%
%      H = LOGISTICGUI returns the handle to a new LOGISTICGUI or the handle to
%      the existing singleton*.
%
%      LOGISTICGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGISTICGUI.M with the given input arguments.
%
%      LOGISTICGUI('Property','Value',...) creates a new LOGISTICGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LogisticGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LogisticGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LogisticGUI

% Last Modified by GUIDE v2.5 28-Aug-2014 16:51:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LogisticGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LogisticGUI_OutputFcn, ...
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


% --- Executes just before LogisticGUI is made visible.
function LogisticGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LogisticGUI (see VARARGIN)

% Choose default command line output for LogisticGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LogisticGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LogisticGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in NormPredictors.
function NormPredictors_Callback(hObject, eventdata, handles)
% hObject    handle to NormPredictors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NormPredictors


% --- Executes on button press in NormInteractions.
function NormInteractions_Callback(hObject, eventdata, handles)
% hObject    handle to NormInteractions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NormInteractions


% --- Executes on button press in AutoRefresh.
function AutoRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to AutoRefresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AutoRefresh


% --- Executes on button press in RefreshButton.
function RefreshButton_Callback(hObject, eventdata, handles)
% hObject    handle to RefreshButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlotIndividual.
function PlotIndividual_Callback(hObject, eventdata, handles)
% hObject    handle to PlotIndividual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotIndividual


% --- Executes on button press in PlotMeans.
function PlotMeans_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotMeans


% --- Executes on selection change in ChoosePredictor.
function ChoosePredictor_Callback(hObject, eventdata, handles)
% hObject    handle to ChoosePredictor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChoosePredictor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChoosePredictor


% --- Executes during object creation, after setting all properties.
function ChoosePredictor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChoosePredictor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ChooseResponse.
function ChooseResponse_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChooseResponse contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChooseResponse


% --- Executes during object creation, after setting all properties.
function ChooseResponse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ChooseExclusion.
function ChooseExclusion_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseExclusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChooseExclusion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChooseExclusion


% --- Executes during object creation, after setting all properties.
function ChooseExclusion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseExclusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ModelComponents.
function ModelComponents_Callback(hObject, eventdata, handles)
% hObject    handle to ModelComponents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ModelComponents contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ModelComponents


% --- Executes during object creation, after setting all properties.
function ModelComponents_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModelComponents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
