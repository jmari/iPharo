Class {
	#name : #IPIntTextModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPIntTextModel class >> modelName [
	^ 'IntTextModel'
]

{ #category : #'instance creation' }
IPIntTextModel class >> newInstance [
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
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#msg_throttle -> 1.
				#layout -> nil.
				#style -> nil.
				#value -> 0.	} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPIntTextModel class >> viewName [
	^ 'IntTextView'
]
