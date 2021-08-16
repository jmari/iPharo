Class {
	#name : #IPColorPickerModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPColorPickerModel class >> modelName [
	^ 'ColorPickerModel'
]

{ #category : #'instance creation' }
IPColorPickerModel class >> newInstance [
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
				#concise -> false.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#layout -> nil.
				#msg_throttle -> 1.
				#style -> nil.
				#value -> 'black'} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPColorPickerModel class >> viewName [
	^ 'ColorPickerView'
]
