function varargout = Image_Editor_GUI(varargin)
% NAME: AGBAJE ABDULLATEEF OLAYIDE
%% MATLAB PROJECT ON DESIGN AND DEVELOPMENT OF IMAGE EDITOR APPLICATION
%
% Image_Editor_GUI MATLAB code for Image_Editor_GUI.fig
%      Image_Editor_GUI, by itself, creates a new Image_Editor_GUI or raises the existing
%      singleton*.
%
%      H = Image_Editor_GUI returns the handle to a new Image_Editor_GUI or the handle to
%      the existing singleton*.
%
%      Image_Editor_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Image_Editor_GUI.M with the given input arguments.
%
%      Image_Editor_GUI('Property','Value',...) creates a new Image_Editor_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Editor_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Editor_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Editor_GUI

% Last Modified by GUIDE v2.5 11-Nov-2019 17:10:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Editor_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Editor_GUI_OutputFcn, ...
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


% --- Executes just before Image_Editor_GUI is made visible.
function Image_Editor_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Editor_GUI (see VARARGIN)
%% THE BACKGROUND
% Choose default command line output for Image_Editor_GUI
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
% import the background image and show it on the axes
bg = imread('example.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');
% Update handles structure
guidata(hObject, handles);

axes(handles.axes6); 
logo=imread('APERSOFT-LOGO.jpg');
imshow(logo); % show Beihang logo in axes 6
% UIWAIT makes Image_Editor_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Editor_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% menu to select image and extract the path
[filename, pathname]= uigetfile({'*.jpg';'*.png'},'File Select');
global image2; % make variable accessible
image= fullfile(pathname, filename); % image path
image2 = imread(image); %read image
% To extract image information
[pathstr, name, ext] = fileparts(filename);
fileinfo=imfinfo(image); 
FileSize1=fileinfo.FileSize(1,1);
sizew=fileinfo.Width(1,1);
sizeh=fileinfo.Height(1,1);

axes(handles.axes1);
imshow(image2);
% Link image information to handles
set(handles.edit1,'string',name);
set(handles.edit2,'string',ext);
set(handles.edit3,'string',sizeh);
set(handles.edit4,'string',sizew);
set(handles.edit5,'string',FileSize1);
set(handles.edit6,'string',image);
axes(handles.axes4);
histogram(image2); % display image histogram on axes 4


%% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
imsave; % save image on axes 3

%% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
global image2; % accessing global variable
a=rgb2gray(image2); % image conversion
imshow(a);
axes(handles.axes4);
imhist(a,64); % grayscale image histogram

%% --- Executes on button press in black_n_white.
function black_n_white_Callback(hObject, eventdata, handles)
% hObject    handle to black_n_white (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
global image2;
b=im2bw(image2); % image conversion black and white
imshow(b);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axes(handles.axes3);
global image2;
val=0.5*get(hObject,'Value')-0.5; % range of slider movement
imbright=image2+val; % apply range of slider on image
imshow(imbright);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6


%% --- Executes on button press in Red_Comp.
function Red_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Red_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
redC = image2;
redC(:,:,2)=0; % turn off green and blue component of rgb
redC(:,:,3)=0;
axes(handles.axes3);
imshow(redC);

%% --- Executes on button press in Green_Comp.
function Green_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Green_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
GreenC = image2;
GreenC(:,:,1)=0; % turn off red and blue component of rgb
GreenC(:,:,3)=0;
axes(handles.axes3);
imshow(GreenC);

%% --- Executes on button press in Blue_Comp.
function Blue_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Blue_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
BlueC = image2;
BlueC(:,:,1)=0; % turn off green and red component of rgb
BlueC(:,:,2)=0;
axes(handles.axes3);
imshow(BlueC);


%% --- Executes on button press in Yellow_Comp.
function Yellow_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Yellow_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
YellowC = image2;
YellowC(:,:,3)=0; % turn off blue component of rgb
axes(handles.axes3);
imshow(YellowC);

%% --- Executes on button press in Lilac_Comp.
function Lilac_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Lilac_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
LilacC = image2;
LilacC(:,:,2)=0; % turn off green component of rgb
axes(handles.axes3);
imshow(LilacC);

%% --- Executes on button press in Sky_Comp.
function Sky_Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Sky_Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
SkyC = image2;
SkyC(:,:,1)=0; % turn off red component of rgb
axes(handles.axes3);
imshow(SkyC);


%% --- Executes on button press in Flip_horizontal.
function Flip_horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to Flip_horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
hor = image2;
hor = flipdim(hor,2); % flip image horizontal
axes(handles.axes3);
imshow(hor);

%% --- Executes on button press in Flip_vertical.
function Flip_vertical_Callback(hObject, eventdata, handles)
% hObject    handle to Flip_vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2;
ver = image2;
ver = flip(ver,1); % flip image vertically
axes(handles.axes3);
imshow(ver);



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
