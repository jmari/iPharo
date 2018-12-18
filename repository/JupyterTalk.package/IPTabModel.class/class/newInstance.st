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
				#_dom_classes -> {}.
				#_titles ->{}.
				#box_style -> ''. "'success', 'info', 'warning', 'danger', ''"
				#children -> {}.
				#layout -> nil.
				#msg_throttle -> 1.
				#selected_index ->0} asSCJsonObject }.
