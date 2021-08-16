Class {
	#name : #IPToggleButtonsModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPToggleButtonsModel class >> modelName [
	^ 'ToggleButtonsModel'
]

{ #category : #'instance creation' }
IPToggleButtonsModel class >> newInstance [
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
				#_options_labels -> {}.		
				#button_style -> ''.	"'primary', 'success', 'info', 'warning', 'danger', ''"
				#description -> ''.
				#descriptnio_tooltip -> nil.
				#disabled -> false.
				#icons -> {}.
				#index -> nil.
				#layout -> nil.	
				#msg_throttle -> 1.
				#icons -> {}.
				#style -> nil.
				#tooltips -> {}.
				#value -> nil	} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPToggleButtonsModel class >> viewName [
	^ 'ToggleButtonsView'
]
