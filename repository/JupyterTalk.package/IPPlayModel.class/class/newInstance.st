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
				#_playing->false.
				#description -> ''.
				#disabled	-> false.
				#interval	 -> 100.
 				#layout	-> nil.
				#max	-> 100.
				#min -> 0.
				#msg_throttle -> 1.
				#step	-> 1.
				#value	 -> 0} asSCJsonObject }