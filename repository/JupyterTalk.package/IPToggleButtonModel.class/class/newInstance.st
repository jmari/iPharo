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
				#button_style -> ''.	"'primary', 'success', 'info', 'warning', 'danger', ''"
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#icon -> ''.
				#layout -> nil.
				#msg_throttle -> 1.
				#style -> nil.
				#tooltip -> ''.
				#value -> false
					} asSCJsonObject }.