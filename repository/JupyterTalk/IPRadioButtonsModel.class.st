Class {
	#name : #IPRadioButtonsModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPRadioButtonsModel class >> modelName [
	^ 'RadioButtonsModel'
]

{ #category : #'instance creation' }
IPRadioButtonsModel class >> newInstance [
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
				#_options_values -> {}.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#index -> nil.
				#layout -> nil.
				#style -> nil.
				#msg_throttle -> 1.
				#value -> nil } asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPRadioButtonsModel class >> viewName [
	^ 'RadioButtonsView'
]
