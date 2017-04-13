function varargout = calc(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
									 'gui_Singleton',  gui_Singleton, ...
									 'gui_OpeningFcn', @calc_OpeningFcn, ...
									 'gui_OutputFcn',  @calc_OutputFcn, ...
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


% --- Executes just before calc is made visible.
function calc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calc (see VARARGIN)

% Choose default command line output for calc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = calc_OutputFcn(hObject, eventdata, handles) 
	% varargout  cell array for returning output args (see VARARGOUT);
	% hObject    handle to figure
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;

% set(handles.Tag, 'Type', data);
% get(handles.Tag, 'Type');

function numReg1_Callback(hObject, eventdata, handles)
	if(strcmp(get(handles.numReg1,'String'), 'Register 1'))
			fprintf('')
			set(handles.numReg1, 'String', '');
		else
			bitSize = get(handles.regSize,'value');
			bitSize = (2^bitSize);
			if(str2num(get(handles.numReg1,'string')) > (bitSize))
				h = errordlg('Number too large for register. Register size has been increased.', 'Overflow');
				while(str2num(get(handles.numReg1,'string')) > (bitSize))
					tempBitSize = get(handles.regSize,'value')+1;
					set(handles.regSize,'value', tempBitSize);
					bitSize = (2^(get(handles.regSize,'value')));
				end
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
			elseif(isempty(str2num(get(handles.numReg1,'string'))))
				h = errordlg('Please enter a number.', 'Non-Number');
				set(handles.numReg1, 'String', '');
			else
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
			end
	end
		
% --- Executes during object creation, after setting all properties.
function numReg1_CreateFcn(hObject, eventdata, handles)
	% hObject    handle to numReg1 (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    empty - handles not created until after all CreateFcns called

	% Hint: edit controls usually have a white background on Windows.
	%       See ISPC and COMPUTER.
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)

% --- Executes on button press in negButton.
function negButton_Callback(hObject, eventdata, handles)

% --- Executes on selection change in regSize.
function regSize_Callback(hObject, eventdata, handles)
	bitSize = get(handles.regSize,'value');
	bitSize = (2^bitSize);
	%Sets first register to new value
	binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
	set(handles.reg1, 'Data', binary);
	%Sets second register
	binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
	set(handles.reg2, 'Data', binary);

% --- Executes during object creation, after setting all properties.
function regSize_CreateFcn(hObject, eventdata, handles)
	% hObject    handle to regSize (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    empty - handles not created until after all CreateFcns called

	% Hint: listbox controls usually have a white background on Windows.
	%       See ISPC and COMPUTER.
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

function numReg2_Callback(hObject, eventdata, handles)
	if(strcmp(get(handles.numReg2,'String'), 'Register 1'))
			fprintf('')
			set(handles.numReg2, 'String', '');
		else
			bitSize = get(handles.regSize,'value');
			bitSize = (2^bitSize);
			if(str2num(get(handles.numReg2,'string')) > (bitSize))
				h = errordlg('Number too large for register. Register size has been increased.', 'Overflow');
				while(str2num(get(handles.numReg2,'string')) > (bitSize))
					tempBitSize = get(handles.regSize,'value')+1;
					set(handles.regSize,'value', tempBitSize);
					bitSize = (2^(get(handles.regSize,'value')));
				end
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg2, 'Data', binary);
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
			elseif(isempty(str2num(get(handles.numReg2,'string'))))
				h = errordlg('Please enter a number.', 'Non-Number');
				set(handles.numReg2, 'String', '');
			else
				binary = reshape(decimalToBinaryVector(str2num(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg2, 'Data', binary);
			end
	end

% --- Executes during object creation, after setting all properties.
function numReg2_CreateFcn(hObject, eventdata, handles)
	% hObject    handle to numReg2 (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    empty - handles not created until after all CreateFcns called

	% Hint: edit controls usually have a white background on Windows.
	%       See ISPC and COMPUTER.
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

% --- Executes on button press in equalButton.
function equalButton_Callback(hObject, eventdata, handles)


% --- Executes during object deletion, before destroying properties.
function reg1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to reg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function reg1_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));
% hObject    handle to reg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function reg2_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));
% hObject    handle to reg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function reg3_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));
% hObject    handle to reg3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
