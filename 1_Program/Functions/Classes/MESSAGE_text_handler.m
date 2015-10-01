classdef MESSAGE_text_handler < handle
	%MESSAGE_TEXT_HANDLER   Class to provide methods to manage GUI text fields
	%   Detailed explanation goes here

	% Version:                 1.0
	% Created by:              Franz Zeilinger - 01.10.2015
	% Last change by:          

	properties
		Current_Text_to_Display = {}
		Current_Text_to_Save = {}
		MAX_Lines = 0
		Line_Count = 0
		handle_textfield
		
		Current_Level = 0
		Blanks_per_Level = 4;
	end
	
	methods
		function obj = MESSAGE_text_handler(handle_textfield, varargin)
			obj.handle_textfield = handle_textfield;
			if nargin > 1
				 warning('Feature not inplemented yet')
			end
			handle_textfield.set('Units','points');
			
			obj.MAX_Lines = floor(...
				handle_textfield.Position(4)/(handle_textfield.get('FontSize')+1.88));
		end
		
		
		function obj = add_line(obj, add_string)
			if obj.Line_Count >= obj.MAX_Lines
				warning('Max. line number exceeded!');
				return;
			end
			
			add_string = [blanks(obj.Current_Level*obj.Blanks_per_Level),add_string];
			
			obj.Current_Text_to_Display{end+1} = add_string;
			obj.Line_Count = obj.Line_Count + 1;
						obj.handle_textfield.set('String',obj.Current_Text_to_Display);
		end

		function obj = rem_line(obj)
			obj.Current_Text_to_Display = obj.Current_Text_to_Display(1:end-1);
			obj.Line_Count = obj.Line_Count - 1;
			if obj.Line_Count < 0
				obj.Line_Count = 0;
			end
			obj.handle_textfield.set('String',obj.Current_Text_to_Display);
		end
		
		function obj = reset_text(obj)
			obj.Current_Text_to_Display = {};
			obj.Line_Count = 0;
			obj.handle_textfield.set('String',obj.Current_Text_to_Display);
		end
		
		function obj = level_up(obj)
			obj.Current_Level = obj.Current_Level - 1;
			if obj.Current_Level < 0
				obj.Current_Level = 0;
			end
		end
		
		function obj = level_down(obj)
			obj.Current_Level = obj.Current_Level + 1;
		end
	end
	
end

