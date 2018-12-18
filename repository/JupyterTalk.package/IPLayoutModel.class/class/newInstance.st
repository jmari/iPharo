instance creation
newInstance
	^ self fromAssociations: 
		{	'version_major'-> self majorVersion.
			'version_minor'-> self minorVersion.
			'state'->{
				#_model_module -> self moduleName. 
				#_model_module_version -> self version.
				#_model_name -> self modelName.
				#_view_module -> self moduleName.
				#_view_module_version -> self version.
				#_view_name -> self viewName.
				#align_content	-> nil. "'flex-start', 'flex-end', 'center', 'space-between', 'space-around', 'space-evenly', 'stretch', 'inherit', 'initial', 'unset'"		
				#align_items	 ->nil."'flex-start', 'flex-end', 'center', 'baseline', 'stretch', 'inherit', 'initial', 'unset'"
				#align_self	->nil. " 'auto', 'flex-start', 'flex-end', 'center', 'baseline', 'stretch', 'inherit', 'initial', 'unset'"	
				#border	 -> nil.
				#bottom	 -> nil.
				#display	 -> nil.
				#flex	 -> nil.
				#flex_flow	 -> nil.
				#height	 -> nil.
				#justify_content	-> nil. "'flex-start', 'flex-end', 'center', 'space-between', 'space-around', 'inherit', 'initial', 'unset'"	
				#left	 -> nil.
				#margin	 -> nil.
				#max_height	 -> nil.
				#max_width	 -> nil.
				#min_height	-> nil. 	
				#min_width -> nil.
				#msg_throttle -> 1.	
				#order	-> nil.
				#overflow	 -> nil. "'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"	
				#overflow_x	 -> nil. " 'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"	
				#overflow_y	 -> nil. " 'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"	
				#padding	-> nil.
				#right	-> nil.
				#top	 -> nil.
				#visibility	 -> nil. "'visible', 'hidden', 'inherit', 'initial', 'unset'"
				#width -> nil} asSCJsonObject }.