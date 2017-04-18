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


function calc_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for calc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = calc_OutputFcn(hObject, eventdata, handles) 
	% Get default command line output from handles structure
	varargout{1} = handles.output;

function numReg1_Callback(hObject, eventdata, handles)
	if(strcmp(get(handles.numReg1,'String'), 'Register 1'))
			fprintf('')
			set(handles.numReg1, 'String', '');
		else
			bitSize = get(handles.regSize,'value');
			bitSize = (2^bitSize);
			if(str2double(get(handles.numReg1,'string')) >= (2^bitSize))
				h = errordlg('Number too large for register. Register size has been increased.', 'Overflow');
				while(str2double(get(handles.numReg1,'string')) >= (2^bitSize))
					set(handles.regSize,'value', get(handles.regSize,'value')+1);
					bitSize = 2^(2^(get(handles.regSize,'value')));
                end
                bitSize = get(handles.regSize,'value');
                bitSize = (2^bitSize);
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg2, 'Data', binary);
			elseif(isempty(str2double(get(handles.numReg1,'string'))))
				h = errordlg('Please enter a number.', 'Non-Number');
				set(handles.numReg1, 'String', '');
			else
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
			end
	end
		
function numReg1_CreateFcn(hObject, eventdata, handles)
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

function addButton_Callback(hObject, eventdata, handles)
    if(get(handles.negButton,'value') == 1)
        set(handles.negButton,'value',0);
    end
    
function negButton_Callback(hObject, eventdata, handles)
    if(get(handles.addButton,'value') == 1)
        set(handles.addButton,'value',0);
    end

function regSize_Callback(hObject, eventdata, handles)
	bitSize = get(handles.regSize,'value');
	bitSize = (2^bitSize);
	%Sets first register to new value
	binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
	set(handles.reg1, 'Data', binary);
	%Sets second register
	binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
	set(handles.reg2, 'Data', binary);

function regSize_CreateFcn(hObject, eventdata, handles)
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

function numReg2_Callback(hObject, eventdata, handles)
	if(strcmp(get(handles.numReg2,'String'), 'Register 2'))
			fprintf('')
			set(handles.numReg2, 'String', '');
		else
			bitSize = get(handles.regSize,'value');
			bitSize = (2^bitSize);
			if(str2double(get(handles.numReg2,'string')) >= (2^bitSize))
				h = errordlg('Number too large for register. Register size has been increased.', 'Overflow');
				while(str2double(get(handles.numReg2,'string')) >= (2^bitSize))
					set(handles.regSize,'value', get(handles.regSize,'value')+1);
					bitSize = 2^(2^(get(handles.regSize,'value')));
                end
                bitSize = get(handles.regSize,'value');
                bitSize = (2^bitSize);
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg1,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg1, 'Data', binary);
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg2, 'Data', binary);
			elseif(isempty(str2double(get(handles.numReg1,'string'))))
				h = errordlg('Please enter a number.', 'Non-Number');
				set(handles.numReg2, 'String', '');
			else
				binary = reshape(decimalToBinaryVector(str2double(get(handles.numReg2,'string')), bitSize,'MSBFirst').',1,[]);
				set(handles.reg2, 'Data', binary);
			end
	end

function numReg2_CreateFcn(hObject, eventdata, handles)
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
			set(hObject,'BackgroundColor','white');
	end

function equalButton_Callback(hObject, eventdata, handles)
if(get(handles.addButton,'Value') == 1)
    % Add
    sum = str2double(get(handles.numReg1,'String')) + str2double(get(handles.numReg2,'String'));
    bitSize = get(handles.regSize,'value');
	bitSize = (2^bitSize);
    binary = reshape(decimalToBinaryVector(sum, bitSize,'MSBFirst').',1,[]);
	set(handles.reg3, 'Data', binary);
    set(handles.numFinal, 'String',sum);
else
    diff = str2double(get(handles.numReg1,'String')) - str2double(get(handles.numReg2,'String'));
    if(diff < 0)
        % Oh no
        h = errordlg('Negative Result. The absolute value of the difference is shown.','Negative exception');
        diff = diff * -1;
    end
    bitSize = get(handles.regSize,'value');
	bitSize = (2^bitSize);
    binary = reshape(decimalToBinaryVector(diff, bitSize,'MSBFirst').',1,[]);
	set(handles.reg3, 'Data', binary);
    set(handles.numFinal, 'String',diff);
end

function reg1_DeleteFcn(hObject, eventdata, handles)


function reg1_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));


function reg2_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));


function reg3_CreateFcn(hObject, eventdata, handles)
		set(hObject,'Data',cell(0));
