function varargout = localmoebius_interface(varargin)
% LOCALMOEBIUS_INTERFACE MATLAB code for localmoebius_interface.fig
%      LOCALMOEBIUS_INTERFACE, by itself, creates a new LOCALMOEBIUS_INTERFACE or raises the existing
%      singleton*.
%
%      H = LOCALMOEBIUS_INTERFACE returns the handle to a new LOCALMOEBIUS_INTERFACE or the handle to
%      the existing singleton*.
%
%      LOCALMOEBIUS_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOCALMOEBIUS_INTERFACE.M with the given input arguments.
%
%      LOCALMOEBIUS_INTERFACE('Property','Value',...) creates a new LOCALMOEBIUS_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before localmoebius_interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to localmoebius_interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help localmoebius_interface

% Last Modified by GUIDE v2.5 30-Nov-2016 16:09:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @localmoebius_interface_OpeningFcn, ...
                   'gui_OutputFcn',  @localmoebius_interface_OutputFcn, ...
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


% --- Executes just before localmoebius_interface is made visible.
function localmoebius_interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to localmoebius_interface (see VARARGIN)

% Choose default command line output for localmoebius_interface
handles.output = hObject;

%"Global variables"
 
%Initial positions of points
handles.p1 = [-0.3 0];
handles.handle_p1 = [];
handles.p2 = [0.3 0];
handles.handle_p2 = [];
handles.p3 = [0 0];
handles.handle_p3 = [];

handles.p1_new = [-0.3 0];
handles.handle_p1_new = [];
handles.p2_new = [0.3 0];
handles.handle_p2_new = [];
handles.p3_new = [0 0];
handles.handle_p3_new = [];

%Initial choosen function
handles.function = 'Gaussian';
%Initial function parameters
handles.center = [.01 .01];
handles.handle_center = [];

handles.sigmax = 1;
handles.sigmay = 1;
handles.theta = 0;
handles.t = linspace(0,2*pi,100);


handles.showoutpoints = 1;
handles.showinputpoints = 1;
handles.showfunc = 1;

displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
handles.showdispvect = 0;
%Display the initial input/output image
handles.inputfilename = 'grabodrertorv.jpg';

%Create the basic images for the 10 transformations

%Obtain the values of used transformations
handles.usedT = [1 1 1 1 1 1 1 1 1 1];
handles.currenttransf = 1;

%saves the parameters in a matrix;
handles.redpoints = [handles.p1; handles.p1; handles.p1; handles.p1; handles.p1; handles.p1; ...
                   handles.p1; handles.p1; handles.p1; handles.p1];
handles.greenpoints = [handles.p2; handles.p2; handles.p2; handles.p2; handles.p2; ...
                    handles.p2; handles.p2; handles.p2; handles.p2; handles.p2];
handles.bluepoints = [handles.p3; handles.p3; handles.p3; handles.p3; handles.p3; handles.p3; ...
                    handles.p3; handles.p3; handles.p3; handles.p3];
handles.nredpoints = [handles.p1_new; handles.p1_new; handles.p1_new; handles.p1_new; ...
                    handles.p1_new; handles.p1_new; handles.p1_new; handles.p1_new; handles.p1_new; handles.p1_new];
handles.ngreenpoints = [handles.p2_new; handles.p2_new; handles.p2_new; handles.p2_new; ...
                    handles.p2_new; handles.p2_new; handles.p2_new; handles.p2_new; handles.p2_new; handles.p2_new];
handles.nbluepoints = [handles.p3_new; handles.p3_new; handles.p3_new; handles.p3_new; ...
                handles.p3_new; handles.p3_new; handles.p3_new; handles.p3_new; handles.p3_new; handles.p3_new];                
handles.centers = [handles.center; handles.center; handles.center; handles.center; handles.center;...
                   handles.center; handles.center; handles.center; handles.center; handles.center];
handles.gaussian = [handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta;
                    handles.sigmax handles.sigmay handles.theta];
handles.functions = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10;'Gaussian','Gaussian','Gaussian','Gaussian','Gaussian','Gaussian','Gaussian',...
    'Gaussian', 'Gaussian', 'Gaussian'};

axes(handles.initialimage)
handles.matlabImage = imread(handles.inputfilename);
[handles.m_input handles.n_input ~] = size(handles.matlabImage);
handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;

image(handles.matlabImage)
hold on
handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
handles.handle_showfunc = plot(handles.xaxis,handles.yaxis, 'y');
 handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off

addpath('../codigo');
% default resolution for output
 handles.m_output = handles.m_input;
 handles.n_output = handles.n_input;
% handles.output_show_points = 1;
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
% handles.output_image = handles.calcfinalimage;
axes(handles.finalimage)
image(handles.output_image)
handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1);

image(handles.output_image)
hold on
handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
handles.handle_showfunc2 = plot(handles.xaxis,handles.yaxis,'y');
handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off

% Setting the transformations
handles.currenttransf = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes localmoebius_interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = localmoebius_interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in choosefunc.
function choosefunc_Callback(hObject, eventdata, handles)
% hObject    handle to choosefunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

valor = get(hObject,'Value');
switch valor
    case 1
        handles.function = 'Gaussian';
    case 2
        handles.function = 'Linear';
    case 3
        handles.function = 'Quadratic';
    case 4
        handles.function = 'Cubic';
    case 5
        handles.function = 'LineRect';
end
str = handles.currenttransf;
handles.functions(2,str) = {handles.function};

axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject,handles);
%        contents{get(hObject,'Value')} returns selected item from choosefunc


% --- Executes during object creation, after setting all properties.
function choosefunc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choosefunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in insertimage.
function insertimage_Callback(hObject, eventdata, handles)
% hObject    handle to insertimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% FUN��O PRONTA!
[filename pathname] = uigetfile({'*.jpg'},'File Selector');
inputfilename = strcat(pathname,filename);
handles.inputfilename = inputfilename;

axes(handles.initialimage)
handles.matlabImage = imread(handles.inputfilename);
[handles.m_input handles.n_input ~] = size(handles.matlabImage);
image(handles.matlabImage)
hold on
handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off

 handles.m_output = handles.m_input;
 handles.n_output = handles.n_input;
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
hold on
handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off

guidata(hObject, handles);

function xredpos_Callback(hObject, eventdata, handles)
% hObject    handle to xredpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p1(1) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end

if (handles.showdisvectors == 1)
    handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,1) = handles.p1(1);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xredpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xredpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in red_rbutton.
function red_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to red_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1(1) = handles.p1(1) + 0.02;
%Update the string
str = num2str(handles.p1(1));
  set(handles.xredpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end



if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,1) = handles.p1(1);

guidata(hObject, handles);



% --- Executes on button press in red_lbutton.
function red_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to red_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1(1) = handles.p1(1) - 0.02;
%Update the string
str = num2str(handles.p1(1));
  set(handles.xredpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end



if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,1) = handles.p1(1);

guidata(hObject, handles);



function yredpos_Callback(hObject, eventdata, handles)
% hObject    handle to yredpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)str = get(hObject,'string');

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p1(2) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end

if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,2) = handles.p1(2);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function yredpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yredpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function red_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to red_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1(2) = handles.p1(2) + 0.02;
%Update the string
str = num2str(handles.p1(2));
  set(handles.yredpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,2) = handles.p1(2);

guidata(hObject, handles);

% --- Executes on button press in red_dbutton.
function red_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to red_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1(2) = handles.p1(2) - 0.02;
%Update the string
str = num2str(handles.p1(2));
  set(handles.yredpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p1);
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.redpoints(str,2) = handles.p1(2);

guidata(hObject, handles);



function xgreenpos_Callback(hObject, eventdata, handles)
% hObject    handle to xgreenpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p2(1) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,1) = handles.p2(1);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function xgreenpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xgreenpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in green_rbutton.
function green_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to green_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2(1) = handles.p2(1) + 0.02;
%Update the string
str = num2str(handles.p2(1));
  set(handles.xgreenpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,1) = handles.p2(1);

guidata(hObject, handles);

% --- Executes on button press in green_lbutton.
function green_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to green_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2(1) = handles.p2(1) - 0.02;
%Update the string
str = num2str(handles.p2(1));
  set(handles.xgreenpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,1) = handles.p2(1);

guidata(hObject, handles);


function ygreenpos_Callback(hObject, eventdata, handles)
% hObject    handle to ygreenpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p2(2) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,2) = handles.p2(2);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ygreenpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ygreenpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in green_ubutton.
function green_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to green_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2(2) = handles.p2(2) + 0.02;
%Update the string
str = num2str(handles.p2(2));
  set(handles.ygreenpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,2) = handles.p2(2);

guidata(hObject, handles);

% --- Executes on button press in green_dbutton.
function green_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to green_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2(2) = handles.p2(2) - 0.02;
%Update the string
str = num2str(handles.p2(2));
  set(handles.ygreenpos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p2);
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.greenpoints(str,2) = handles.p2(2);

guidata(hObject, handles);


function xbluepos_Callback(hObject, eventdata, handles)
% hObject    handle to xbluepos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p3(1) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
        handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,1) = handles.p3(1);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xbluepos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xbluepos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ybluepos_Callback(hObject, eventdata, handles)
% hObject    handle to ybluepos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p3(2) = str2num(str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,2) = handles.p3(2);


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ybluepos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ybluepos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in blue_rbutton.
function blue_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to blue_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3(1) = handles.p3(1) + 0.02;
%Update the string
str = num2str(handles.p3(1));
  set(handles.xbluepos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,1) = handles.p3(1);

guidata(hObject, handles);

% --- Executes on button press in blue_lbutton.
function blue_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to blue_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3(1) = handles.p3(1) - 0.02;
%Update the string
str = num2str(handles.p3(1));
  set(handles.xbluepos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,1) = handles.p3(1);

guidata(hObject, handles);






% --- Executes on button press in blue_ubutton.
function blue_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to blue_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3(2) = handles.p3(2) + 0.02;
%Update the string
str = num2str(handles.p3(2));
  set(handles.ybluepos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
     handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,2) = handles.p3(2);

guidata(hObject, handles);

% --- Executes on button press in blue_dbutton.
function blue_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to blue_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3(2) = handles.p3(2) - 0.02;
%Update the string
str = num2str(handles.p3(2));
  set(handles.ybluepos, 'string', str);
if (handles.showinputpoints == 1)
    axes(handles.initialimage)
    hold on
    delete(handles.handle_p3);
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
    hold off
    axis off
end
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.bluepoints(str,2) = handles.p3(2);

guidata(hObject, handles);


function xcenterpos_Callback(hObject, eventdata, handles)
% hObject    handle to xcenterpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
str = get(hObject,'string');
handles.center(1) = str2num(str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,1) = handles.center(1);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xcenterpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xcenterpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in center_rbutton.
function center_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to center_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.center(1) = handles.center(1) + 0.02;
%Update the string
str = num2str(handles.center(1));
  set(handles.xcenterpos, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,1) = handles.center(1);

guidata(hObject, handles);


% --- Executes on button press in center_lbutton.
function center_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to center_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.center(1) = handles.center(1) - 0.02;
%Update the string
str = num2str(handles.center(1));
  set(handles.xcenterpos, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,1) = handles.center(1);

guidata(hObject, handles);


function ycenterpos_Callback(hObject, eventdata, handles)
% hObject    handle to ycenterpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
str = get(hObject,'string');
handles.center(2) = str2num(str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
     handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,2) = handles.center(2);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ycenterpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ycenterpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in center_ubutton.
function center_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to center_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.center(2) = handles.center(2) + 0.02;
%Update the string
str = num2str(handles.center(2));
  set(handles.ycenterpos, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,2) = handles.center(2);

guidata(hObject, handles);


% --- Executes on button press in center_dbutton.
function center_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to center_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.center(2) = handles.center(2) - 0.02;
%Update the string
str = num2str(handles.center(2));
  set(handles.ycenterpos, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.centers(str,2) = handles.center(2);

guidata(hObject, handles);



function sigmaxvalue_Callback(hObject, eventdata, handles)
% hObject    handle to sigmaxvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
str = get(hObject,'string');
handles.sigmax = str2num(str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off


if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,1) = handles.sigmax;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sigmaxvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigmaxvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sigmax_ubutton.
function sigmax_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to sigmax_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.sigmax = handles.sigmax + 0.02;
%Update the string
str = num2str(handles.sigmax);
  set(handles.sigmaxvalue, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,1) = handles.sigmax;

guidata(hObject, handles);


% --- Executes on button press in sygmax_dbutton.
function sygmax_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sygmax_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.sigmax = handles.sigmax - 0.02;
%Update the string
str = num2str(handles.sigmax);
  set(handles.sigmaxvalue, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,1) = handles.sigmax;

guidata(hObject, handles);


function sigmayvalue_Callback(hObject, eventdata, handles)
% hObject    handle to sigmayvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
str = get(hObject,'string');
handles.sigmay = str2num(str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,2) = handles.sigmay;

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function sigmayvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigmayvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sigmay_ubutton.
function sigmay_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to sigmay_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.sigmay = handles.sigmay + 0.02;
%Update the string
str = num2str(handles.sigmay);
  set(handles.sigmayvalue, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,2) = handles.sigmay;

guidata(hObject, handles);

% --- Executes on button press in sigmay_dbutton.
function sigmay_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sigmay_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.sigmay = handles.sigmay - 0.02;
%Update the string
str = num2str(handles.sigmay);
  set(handles.sigmayvalue, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,2) = handles.sigmay;

guidata(hObject, handles);



function theta_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
str = get(hObject,'string');
handles.theta = str2num(str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end


str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,3) = handles.theta;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function theta_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in theta_ubutton.
function theta_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to theta_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.theta = handles.theta + 0.02;
%Update the string
str = num2str(handles.theta);
  set(handles.theta_value, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,3) = handles.theta;

guidata(hObject, handles);


% --- Executes on button press in theta_dbutton.
function theta_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to theta_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TEM QUE ARRUMAR A FUN��O!!! TEM QUE LIMITAR OS AXIS
handles.theta = handles.theta - 0.02;
%Update the string
str = num2str(handles.theta);
  set(handles.theta_value, 'string', str);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.gaussian(str,3) = handles.theta;

guidata(hObject, handles);





function nredxpos_Callback(hObject, eventdata, handles)
% hObject    handle to nredxpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p1_new(1) = str2num(str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,1) = handles.p1_new(1);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nredxpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nredxpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nred_rbutton.
function nred_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nred_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1_new(1) = handles.p1_new(1) + 0.02;

str = num2str(handles.p1_new(1));
set(handles.nredxpos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,1) = handles.p1_new(1);
guidata(hObject, handles);


% --- Executes on button press in nred_lbutton.
function nred_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nred_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1_new(1) = handles.p1_new(1) - 0.02;

str = num2str(handles.p1_new(1));
set(handles.nredxpos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,1) = handles.p1_new(1);

guidata(hObject, handles);


function nredypos_Callback(hObject, eventdata, handles)
% hObject    handle to nredypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p1_new(2) = str2num(str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,2) = handles.p1_new(2);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nredypos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nredypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nred_ubutton.
function nred_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to nred_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1_new(2) = handles.p1_new(2) + 0.02;

str = num2str(handles.p1_new(2));
if abs(handles.p1_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.nredypos, 'string', str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,2) = handles.p1_new(2);

guidata(hObject, handles);


% --- Executes on button press in nred_dbutton.
function nred_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nred_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p1_new(2) = handles.p1_new(2) - 0.02;

str = num2str(handles.p1_new(2));
if abs(handles.p1_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.nredypos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nredpoints(str,2) = handles.p1_new(2);

guidata(hObject, handles);





function ngreenxpos_Callback(hObject, eventdata, handles)
% hObject    handle to ngreenxpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p2_new(1) = str2num(str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,1) = handles.p2_new(1);

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function ngreenxpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngreenxpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ngreen_rbutton.
function ngreen_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ngreen_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2_new(1) = handles.p2_new(1) + 0.02;

str = num2str(handles.p2_new(1));
if abs(handles.p2_new(1)) < 0.00000000001
    str = '0.0';
end
set(handles.ngreenxpos, 'string', str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,1) = handles.p2_new(1);

guidata(hObject, handles);


% --- Executes on button press in ngreen_lbutton.
function ngreen_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ngreen_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2_new(1) = handles.p2_new(1) - 0.02;

str = num2str(handles.p2_new(1));
if abs(handles.p2_new(1)) < 0.00000000001
    str = '0.0';
end
set(handles.ngreenxpos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,1) = handles.p2_new(1);

guidata(hObject, handles);


function ngreenypos_Callback(hObject, eventdata, handles)
% hObject    handle to ngreenypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p2_new(2) = str2num(str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,2) = handles.p2_new(2);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ngreenypos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngreenypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ngreen_ubutton.
function ngreen_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to ngreen_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2_new(2) = handles.p2_new(2) + 0.02;

str = num2str(handles.p2_new(2));
if abs(handles.p2_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.ngreenypos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,2) = handles.p2_new(2);

guidata(hObject, handles);


% --- Executes on button press in ngreen_dbutton.
function ngreen_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ngreen_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p2_new(2) = handles.p2_new(2) - 0.02;

str = num2str(handles.p2_new(2));
if abs(handles.p2_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.ngreenypos, 'string', str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
str = handles.currenttransf;
%Update the Transformations matrix
handles.ngreenpoints(str,2) = handles.p2_new(2);

guidata(hObject, handles);



function nbluexpos_Callback(hObject, eventdata, handles)
% hObject    handle to nbluexpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p3_new(1) = str2num(str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,1) = handles.p3_new(1);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nbluexpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nbluexpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nblue_rbutton.
function nblue_rbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nblue_rbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3_new(1) = handles.p3_new(1) + 0.02;

str = num2str(handles.p3_new(1));
if abs(handles.p3_new(1)) < 0.00000000001
    str = '0.0';
end
set(handles.nbluexpos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,1) = handles.p3_new(1);

guidata(hObject, handles);

% --- Executes on button press in nblue_lbutton.
function nblue_lbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nblue_lbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3_new(1) = handles.p3_new(1) - 0.02;

str = num2str(handles.p3_new(1));
if abs(handles.p3_new(1)) < 0.00000000001
    str = '0.0';
end
set(handles.nbluexpos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,1) = handles.p3_new(1);

guidata(hObject, handles);



function nblueypos_Callback(hObject, eventdata, handles)
% hObject    handle to nblueypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
str = get(hObject,'string');
handles.p3_new(2) = str2num(str);

if (handles.showdisvectors == 1)
       handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,2) = handles.p3_new(2);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nblueypos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nblueypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in nblue_ubutton.
function nblue_ubutton_Callback(hObject, eventdata, handles)
% hObject    handle to nblue_ubutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3_new(2) = handles.p3_new(2) + 0.02;

str = num2str(handles.p3_new(2));
if abs(handles.p3_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.nblueypos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,2) = handles.p3_new(2);

guidata(hObject, handles);


% --- Executes on button press in nblue_dbutton.
function nblue_dbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nblue_dbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%FUN��O PRONTA!!
handles.p3_new(2) = handles.p3_new(2) - 0.02;

str = num2str(handles.p3_new(2));
if abs(handles.p3_new(2)) < 0.00000000001
    str = '0.0';
end
set(handles.nblueypos, 'string', str);

if (handles.showdisvectors == 1)
      handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    axes(handles.finalimage)
        displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off

else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

str = handles.currenttransf;
%Update the Transformations matrix
handles.nbluepoints(str,2) = handles.p3_new(2);

guidata(hObject, handles);



% % --- Executes on button press in pushbutton4.
% function pushbutton4_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% % --- Executes on button press in pushbutton5.
% function pushbutton5_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)


% -----------------------------------------------------------------------
% PARTE DO C�DIGO RESPONS�VEL POR MOSTRAR OS ELEMENTOS NA IMAGEM


% --- Executes on button press in showfunc.
function showfunc_Callback(hObject, eventdata, handles)
% hObject    handle to showfunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject,'Value');
handles.showfunc = str;

if (handles.showfunc == 1)
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');

 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
axes(handles.finalimage)
image(handles.output_image)
    hold on
if (handles.showoutpoints ==1)

    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');

end
handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off
end
if (handles.showfunc == 0)
    axes(handles.initialimage)
    image(handles.matlabImage)
    hold on
     if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off
axes(handles.finalimage)
image(handles.output_image)
    hold on
if (handles.showoutpoints == 1)

    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');

end
hold off
axis off

end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of showfunc
% --- Executes on button press in showinputpoints.
function showinputpoints_Callback(hObject, eventdata, handles)
% hObject    handle to showinputpoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This function show/hide the input points on image 
axes(handles.initialimage)
if (handles.showinputpoints == 1)
    handles.showinputpoints = 0;
    delete(handles.handle_p1);
    delete(handles.handle_p2);
    delete(handles.handle_p3);
else
    handles.showinputpoints=1;
    hold on
    handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of showinputpoints


% --- Executes on button press in showoutpoints.
function showoutpoints_Callback(hObject, eventdata, handles)
% hObject    handle to showoutpoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Shows/hide the output points
axes(handles.finalimage)
if (handles.showoutpoints==1)
    handles.showoutpoints=0;
    delete(handles.handle_p1_new);
    delete(handles.handle_p2_new);
    delete(handles.handle_p3_new);
else
    handles.showoutpoints=1;
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of showoutpoints


% --- Executes on button press in showdisvectors.
function showdisvectors_Callback(hObject, eventdata, handles)
% hObject    handle to showdisvectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.finalimage)
if (handles.showdisvectors == 1)
    handles.showdisvectors = 0;
    delete(handles.displacement)
    handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
    image(handles.output_image)
    hold on
    if (handles.showoutpoints==1)
        handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
        handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
        handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    end
    if (handles.showfunc == 1)
        handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
        handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    end
    hold off
    axis off
else
    handles.showdisvectors=1;
    
    displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    Z = ones(60,30)*3;
    Z_2 = zeros(60,30);
    image(handles.output_image)
    hold on
    handles.displacement = quiver(((handles.posx+pi)/(2*pi))*handles.n_input,((-handles.posy+pi/2)/pi)*handles.m_input,((handles.dispx)/(2*pi))*handles.n_input,((handles.dispy)/pi)*handles.m_input,'b','LineWidth', 1.3);
    hold off
    axis off
end
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of showdisvectors

% --- Executes on button press in newtransf.
function newtransf_Callback(hObject, eventdata, handles)
% hObject    handle to newtransf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.p1 = [-0.3 0];
str = num2str(handles.p1(1));
set(handles.xredpos, 'string', str);
str = num2str(handles.p1(2));
set(handles.yredpos, 'string', str);
handles.handle_p1 = [];
handles.p2 = [0.3 0];
str = num2str(handles.p2(1));
set(handles.xgreenpos, 'string', str);
str = num2str(handles.p2(2));
set(handles.ygreenpos, 'string', str);
handles.handle_p2 = [];
handles.p3 = [0 0];
str = num2str(handles.p3(1));
set(handles.xbluepos, 'string', str);
str = num2str(handles.p3(2));
set(handles.ybluepos, 'string', str);
handles.handle_p3 = [];

handles.p1_new = [-0.3 0];
str = num2str(handles.p1_new(1));
set(handles.nredxpos, 'string', str);
str = num2str(handles.p1_new(2));
set(handles.nredypos, 'string', str);
handles.handle_p1_new = [];
handles.p2_new = [0.3 0];
str = num2str(handles.p2_new(1));
set(handles.ngreenxpos, 'string', str);
str = num2str(handles.p2_new(2));
set(handles.ngreenypos, 'string', str);
handles.handle_p2_new = [];
handles.p3_new = [0 0];
str = num2str(handles.p3_new(1));
set(handles.nbluexpos, 'string', str);
str = num2str(handles.p3_new(2));
set(handles.nblueypos, 'string', str);
handles.handle_p3_new = [];

%Initial choosen function
handles.function = 'Gaussian';
%Initial function parameters
handles.center = [.01 .01];
str = num2str(handles.center(1));
set(handles.xcenterpos, 'string', str);
str = num2str(handles.center(2));
set(handles.ycenterpos, 'string', str);
handles.handle_center = [];
handles.handle_center2 = [];
handles.sigmax = 1;
str = num2str(handles.sigmax);
set(handles.sigmaxvalue, 'string', str);
handles.sigmay = 1;
str = num2str(handles.sigmay);
set(handles.sigmayvalue, 'string', str);
handles.theta = 0;
str = num2str(handles.theta);
set(handles.theta_value, 'string', str);
handles.t = linspace(0,2*pi,100);


handles.showoutpoints = 1;
handles.showinputpoints = 1;
handles.showfunc = 1;
displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
handles.showdispvect = 0;

axes(handles.initialimage)
handles.matlabImage = handles.output_image;
[handles.m_input handles.n_input ~] = size(handles.matlabImage);
handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;

image(handles.matlabImage)
hold on
handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_input,((-handles.p1(2)+pi/2)/pi)*handles.m_input,'r*');
handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_input,((-handles.p2(2)+pi/2)/pi)*handles.m_input,'g*');
handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_input,((-handles.p3(2)+pi/2)/pi)*handles.m_input,'b*');
handles.handle_showfunc = plot(handles.xaxis,handles.yaxis, 'y');
 handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off

addpath('../codigo');
% default resolution for output
 handles.m_output = handles.m_input;
 handles.n_output = handles.n_input;
% handles.output_show_points = 1;
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
% handles.output_image = handles.calcfinalimage;
axes(handles.finalimage)
image(handles.output_image)
handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1);

image(handles.output_image)
hold on
handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
handles.handle_showfunc2 = plot(handles.xaxis,handles.yaxis,'y');
handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
hold off
axis off


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in saveresult.
function saveresult_Callback(hObject, eventdata, handles)
% hObject    handle to saveresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile({'*.jpg'},'Save as');
image_to_save = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],[handles.center(1) handles.center(2)],...
    [handles.sigmax handles.sigmay],handles.theta, handles.function, [handles.m_output handles.n_output]);
imwrite(image_to_save,strcat(pathname,filename),'JPEG');
data = '.dat';

C = strread(filename,'%s','delimiter','.');
C = C(1);
C = strcat(C,data);
C = sscanf(sprintf('%s', C{:}), '%s*');

datafile = fopen(C,'w');

fprintf(datafile,'%s\r\n','%red points coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.redpoints(i,1),handles.redpoints(i,2));
end
fprintf(datafile,'%s\r\n','%green points coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.greenpoints(i,1),handles.greenpoints(i,2));
end
fprintf(datafile,'%s\r\n','%blue points coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.bluepoints(i,1),handles.bluepoints(i,2));
end

fprintf(datafile,'%s\r\n','%red points new coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.nredpoints(i,1),handles.nredpoints(i,2));
end
fprintf(datafile,'%s\r\n','%green points new coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.ngreenpoints(i,1),handles.ngreenpoints(i,2));
end
fprintf(datafile,'%s\r\n','%blue points new coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.nbluepoints(i,1),handles.nbluepoints(i,2));
end

fprintf(datafile,'%s\r\n','%center coordinates');
for i=1:10
    fprintf(datafile,'%f %f\r\n',handles.centers(i,1),handles.centers(i,2));
end

fprintf(datafile,'%s\r\n','%gaussian parameters');
for i=1:10
    fprintf(datafile,'%f %f %f\r\n',handles.gaussian(i,1),handles.gaussian(i,2),handles.gaussian(i,3));
end
fprintf(datafile,'%s\r\n','%smoothing functions');
for i=1:10
    switch handles.functions{2,i}
        case 'Gaussian'
            fprintf(datafile,'%d\r\n',1);
        case 'Linear'
            fprintf(datafile,'%d\r\n',2);
        case 'Quadratic'
            fprintf(datafile,'%d\r\n',3);
        case 'Cubic'
            fprintf(datafile,'%d\r\n',4);
        case 'LineRect'
            fprintf(datafile,'%d\r\n',5);
    end
end

fclose(datafile);





% --- Executes on selection change in currentT.
function currentT_Callback(hObject, eventdata, handles)
% hObject    handle to currentT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'Value');
handles.currenttransf = str;
handles.matlabImage = imread(handles.inputfilename);

if handles.usedT(1) == 1
handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,2)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.functions{2,1},...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
end


if str > 1
for b = 2:str
    if b == str
        handles.matlabImage = handles.output_image;
    end
    if handles.usedT(b) == 1
    handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
        handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
        [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
        handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,2)],...
        [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.functions{2,b},...
        [handles.m_output handles.n_output]);
    end
    
end
end
handles.function = handles.functions{2,str};
switch handles.function
    case 'Gaussian'
        functionvalue = 1;
    case 'Linear'
        functionvalue = 2;
    case 'Quadratic'
        functionvalue = 3;
    case 'Cubic'
        functionvalue = 4;
    case 'LineRect'
        functionvalue = 5;
end
set(handles.choosefunc, 'value', functionvalue);
%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

%Atualiza as strings
str = num2str(handles.p1(1));
  set(handles.xredpos, 'string', str);
  str = num2str(handles.p1(2));
  set(handles.yredpos, 'string', str);
str = num2str(handles.p2(1));
  set(handles.xgreenpos, 'string', str);
str = num2str(handles.p2(2));
  set(handles.ygreenpos, 'string', str);
str = num2str(handles.p3(1));
  set(handles.xbluepos, 'string', str);
str = num2str(handles.p3(2));
  set(handles.ybluepos, 'string', str);
str = num2str(handles.p1_new(1));
set(handles.nredxpos, 'string', str);
str = num2str(handles.p1_new(2));
set(handles.nredypos, 'string', str);
str = num2str(handles.p2_new(1));
set(handles.ngreenxpos, 'string', str);
str = num2str(handles.p2_new(2));
set(handles.ngreenypos, 'string', str);
str = num2str(handles.p3_new(1));
set(handles.nbluexpos, 'string', str);
str = num2str(handles.p3_new(2));
set(handles.nblueypos, 'string', str);

str = num2str(handles.center(1));
set(handles.xcenterpos, 'string', str);
str = num2str(handles.center(2));
set(handles.ycenterpos, 'string', str);
str = num2str(handles.sigmax);
set(handles.sigmaxvalue, 'string', str);
str = num2str(handles.sigmay);
set(handles.sigmayvalue, 'string', str);
str = num2str(handles.theta);
set(handles.theta_value, 'string', str);


        
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns currentT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currentT


% --- Executes during object creation, after setting all properties.
function currentT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uset1.
function uset1_Callback(hObject, eventdata, handles)
% hObject    handle to uset1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = get(hObject, 'value');
if value == 1
    handles.usedT(1) = value;
handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
end



if value == 0
    handles.usedT(1) = value;
    handles.output_image = imread(handles.inputfilename);
end

str = handles.currenttransf;
if str > 1
    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);

    % Hint: get(hObject,'Value') returns toggle state of uset1


% --- Executes on button press in uset2.
function uset2_Callback(hObject, eventdata, handles)
% hObject    handle to uset2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(hObject, 'value');
if value == 1
    handles.usedT(2) = value;
end
if value == 0
    handles.usedT(2) = value;
end

str = handles.currenttransf;
if str >= 2
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset2


% --- Executes on button press in uset3.
function uset3_Callback(hObject, eventdata, handles)
% hObject    handle to uset3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(hObject, 'value');
if value == 1
    handles.usedT(3) = value;
end
if value == 0
    handles.usedT(3) = value;
end

str = handles.currenttransf;
if str >= 3
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset3


% --- Executes on button press in uset4.
function uset4_Callback(hObject, eventdata, handles)
% hObject    handle to uset4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(hObject, 'value');
if value == 1
    handles.usedT(4) = value;
end
if value == 0
    handles.usedT(4) = value;
end

str = handles.currenttransf;
if str >= 4
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset4


% --- Executes on button press in uset5.
function uset5_Callback(hObject, eventdata, handles)
% hObject    handle to uset5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(5) = value;
end
if value == 0
    handles.usedT(5) = value;
end

str = handles.currenttransf;
if str >= 5
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset5


% --- Executes on button press in uset6.
function uset6_Callback(hObject, eventdata, handles)
% hObject    handle to uset6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(6) = value;
end
if value == 0
    handles.usedT(6) = value;
end

str = handles.currenttransf;
if str >= 6
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset6


% --- Executes on button press in uset7.
function uset7_Callback(hObject, eventdata, handles)
% hObject    handle to uset7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(7) = value;
end
if value == 0
    handles.usedT(7) = value;
end

str = handles.currenttransf;
if str >= 7
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset7


% --- Executes on button press in uset8.
function uset8_Callback(hObject, eventdata, handles)
% hObject    handle to uset8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(8) = value;
end
if value == 0
    handles.usedT(8) = value;
end

str = handles.currenttransf;
if str >= 8
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset8


% --- Executes on button press in uset9.
function uset9_Callback(hObject, eventdata, handles)
% hObject    handle to uset9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(9) = value;
end
if value == 0
    handles.usedT(9) = value;
end

str = handles.currenttransf;
if str >= 9
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset9


% --- Executes on button press in uset10.
function uset10_Callback(hObject, eventdata, handles)
% hObject    handle to uset10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


value = get(hObject, 'value');
if value == 1
    handles.usedT(10) = value;
end
if value == 0
    handles.usedT(10) = value;
end

str = handles.currenttransf;
if str == 10
    handles.matlabImage = imread(handles.inputfilename);

    if handles.usedT(1) == 1
    handles.output_image = localmoebius(handles.matlabImage, [handles.redpoints(1,1) handles.redpoints(1,2);...
        handles.greenpoints(1,1) handles.greenpoints(1,2); handles.bluepoints(1,1) handles.bluepoints(1,2)],...
        [handles.nredpoints(1,1) handles.nredpoints(1,2); handles.ngreenpoints(1,1) handles.ngreenpoints(1,2);...
        handles.nbluepoints(1,1) handles.nbluepoints(1,2)],[handles.centers(1,1) handles.centers(1,1)],...
        [handles.gaussian(1,1) handles.gaussian(1,2)],handles.gaussian(1,3),handles.function,...
        [handles.m_output handles.n_output]);
else
    handles.output_image = handles.matlabImage;
    end

    for b = 2:str
        if b == str
            handles.matlabImage = handles.output_image;
        end
        if handles.usedT(b) == 1
            handles.output_image = localmoebius(handles.output_image, [handles.redpoints(b,1) handles.redpoints(b,2);...
            handles.greenpoints(b,1) handles.greenpoints(b,2); handles.bluepoints(b,1) handles.bluepoints(b,2)],...
            [handles.nredpoints(b,1) handles.nredpoints(b,2); handles.ngreenpoints(b,1) handles.ngreenpoints(b,2);...
            handles.nbluepoints(b,1) handles.nbluepoints(b,2)],[handles.centers(b,1) handles.centers(b,1)],...
            [handles.gaussian(b,1) handles.gaussian(b,2)],handles.gaussian(b,3),handles.function,...
            [handles.m_output handles.n_output]);
        end
    end
end

%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);
%Lower Values

handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];

 axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of uset10


% --- Executes on button press in loadlog.
function loadlog_Callback(hObject, eventdata, handles)
% hObject    handle to loadlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename pathname] = uigetfile({'*.dat'},'File Selector');
log = strcat(pathname,filename);
log = fopen(log,'r');

A = textscan(log,'%f %f',10,'HeaderLines',1);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.redpoints = cat(2,N_1,N_2);
B = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', B{1}), '%f*');
N_2 = sscanf(sprintf('%f*', B{2}), '%f*');
handles.greenpoints = cat(2,N_1,N_2);
A = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.bluepoints = cat(2,N_1,N_2);

A = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.nredpoints = cat(2,N_1,N_2);
A = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.ngreenpoints = cat(2,N_1,N_2);
A = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.nbluepoints = cat(2,N_1,N_2);

A = textscan(log,'%f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
handles.centers = cat(2,N_1,N_2);

A = textscan(log,'%f %f %f',10,'HeaderLines',2);
N_1 = sscanf(sprintf('%f*', A{1}), '%f*');
N_2 = sscanf(sprintf('%f*', A{2}), '%f*');
N_3 = sscanf(sprintf('%f*', A{3}), '%f*');
handles.gaussian = cat(2,N_1,N_2,N_3);

A = textscan(log,'%d',10,'HeaderLines',2);
B = sscanf(sprintf('%d*', A{1}), '%d*');
for b=1:10
    switch B(b)
        case 1 
            handles.functions{2,b} = 'Gaussian';
        case 2 
            handles.functions{2,b} = 'Linear';
        case 3 
            handles.functions{2,b} = 'Quadratic';
        case 4 
            handles.functions{2,b} = 'Cubic';
        case 5 
            handles.functions{2,b} = 'LineRect';
    end
end
fclose(log);

handles.usedT = [1 1 1 1 1 1 1 1 1 1];
handles.currenttransf = 1;
set(handles.uset1, 'Value', 1);
set(handles.uset2, 'Value', 1);
set(handles.uset3, 'Value', 1);
set(handles.uset4, 'Value', 1);
set(handles.uset5, 'Value', 1);
set(handles.uset6, 'Value', 1);
set(handles.uset7, 'Value', 1);
set(handles.uset8, 'Value', 1);
set(handles.uset9, 'Value', 1);
set(handles.uset10, 'Value', 1);
set(handles.currentT, 'Value', 1);

handles.function = handles.functions{2,1};
switch handles.function
    case 'Gaussian'
        functionvalue = 1;
    case 'Linear'
        functionvalue = 2;
    case 'Quadratic'
        functionvalue = 3;
    case 'Cubic'
        functionvalue = 4;
    case 'LineRect'
        functionvalue = 5;
end
set(handles.choosefunc, 'value', functionvalue);


%Update actual transf
str = 1;
%Upper Values
handles.p1 = [handles.redpoints(str,1) handles.redpoints(str,2)];
handles.p2 = [handles.greenpoints(str,1) handles.greenpoints(str,2)];
handles.p3 = [handles.bluepoints(str,1) handles.bluepoints(str,2)];
     
%Function Values
handles.center = [handles.centers(str,1) handles.centers(str,2)];
handles.sigmax = handles.gaussian(str,1);
handles.sigmay = handles.gaussian(str,2);
handles.theta = handles.gaussian(str,3);

%Lower Values
handles.p1_new = [handles.nredpoints(str,1) handles.nredpoints(str,2)];
handles.p2_new = [handles.ngreenpoints(str,1) handles.ngreenpoints(str,2)];
handles.p3_new = [handles.nbluepoints(str,1) handles.nbluepoints(str,2)];
%Update image
handles.matlabImage = imread(handles.inputfilename);
    axes(handles.initialimage)
    image(handles.matlabImage)
        hold on  
if (handles.showfunc == 1)
    handles.xaxis = (handles.center(1) + handles.sigmax*cos(handles.t)*cos(handles.theta) - handles.sigmay*sin(handles.t)*sin(handles.theta)...
    + pi)./(2*pi)*handles.n_input;
handles.yaxis = (-handles.center(2) - handles.sigmay*sin(handles.t)*cos(handles.theta) - handles.sigmax*cos(handles.t)*sin(handles.theta)...
    +pi/2)./(pi)*handles.m_input;
    handles.handle_center = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');  
    handles.handle_showfunc = plot(handles.xaxis, handles.yaxis, 'y');
end
 if (handles.showinputpoints == 1)
     handles.handle_p1 = plot(((handles.p1(1)+pi)/(2*pi))*handles.n_output,((-handles.p1(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2 = plot(((handles.p2(1)+pi)/(2*pi))*handles.n_output,((-handles.p2(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3 = plot(((handles.p3(1)+pi)/(2*pi))*handles.n_output,((-handles.p3(2)+pi/2)/pi)*handles.m_output,'b*');
 end
hold off
axis off

if (handles.showdisvectors == 1)
    axes(handles.finalimage)
     displacement = dispvectors([handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta);
    handles.posx = displacement(:,:,1) ;
    handles.posy = displacement(:,:,2) ;
    handles.dispx = displacement(:,:,3) ;
    handles.dispy = displacement(:,:,4) ;
    handles.displacement = quiver(handles.posx,handles.posy,handles.dispx,handles.dispy,'b','LineWidth', 1.3);
    axis off
    axis image
else
% update output image
handles.output_image = localmoebius(handles.matlabImage,[handles.p1; handles.p2; handles.p3],[handles.p1_new; handles.p2_new; handles.p3_new],...
    [handles.center(1) handles.center(2)], [handles.sigmax handles.sigmay],handles.theta,handles.function,[handles.m_output handles.n_output]);
axes(handles.finalimage)
image(handles.output_image)
if (handles.showoutpoints ==1)
    hold on
    handles.handle_p1_new = plot(((handles.p1_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p1_new(2)+pi/2)/pi)*handles.m_output,'r*');
    handles.handle_p2_new = plot(((handles.p2_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p2_new(2)+pi/2)/pi)*handles.m_output,'g*');
    handles.handle_p3_new = plot(((handles.p3_new(1)+pi)/(2*pi))*handles.n_output,((-handles.p3_new(2)+pi/2)/pi)*handles.m_output,'b*');
    hold off
end
if (handles.showfunc == 1)
    hold on
    handles.handle_showfunc = plot(handles.xaxis,handles.yaxis,'y');
    handles.handle_center2 = plot(((handles.center(1)+pi)/(2*pi))*handles.n_input,((-handles.center(2)+pi/2)/pi)*handles.m_input,'y*');
    hold off
end

axis off
end

%Atualiza as strings
str = num2str(handles.p1(1));
  set(handles.xredpos, 'string', str);
  str = num2str(handles.p1(2));
  set(handles.yredpos, 'string', str);
str = num2str(handles.p2(1));
  set(handles.xgreenpos, 'string', str);
str = num2str(handles.p2(2));
  set(handles.ygreenpos, 'string', str);
str = num2str(handles.p3(1));
  set(handles.xbluepos, 'string', str);
str = num2str(handles.p3(2));
  set(handles.ybluepos, 'string', str);
str = num2str(handles.p1_new(1));
set(handles.nredxpos, 'string', str);
str = num2str(handles.p1_new(2));
set(handles.nredypos, 'string', str);
str = num2str(handles.p2_new(1));
set(handles.ngreenxpos, 'string', str);
str = num2str(handles.p2_new(2));
set(handles.ngreenypos, 'string', str);
str = num2str(handles.p3_new(1));
set(handles.nbluexpos, 'string', str);
str = num2str(handles.p3_new(2));
set(handles.nblueypos, 'string', str);

str = num2str(handles.center(1));
set(handles.xcenterpos, 'string', str);
str = num2str(handles.center(2));
set(handles.ycenterpos, 'string', str);
str = num2str(handles.sigmax);
set(handles.sigmaxvalue, 'string', str);
str = num2str(handles.sigmay);
set(handles.sigmayvalue, 'string', str);
str = num2str(handles.theta);
set(handles.theta_value, 'string', str);



guidata(hObject, handles);
