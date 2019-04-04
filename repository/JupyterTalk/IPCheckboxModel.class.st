Class {
	#name : #IPCheckboxModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPCheckboxModel class >> modelName [
	^ 'CheckboxModel'
]

{ #category : #'instance creation' }
IPCheckboxModel class >> newInstance [
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
				#indent -> true.
				#layout -> nil.
				#msg_throttle -> 1.
				#style -> nil.
				#value -> ''} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPCheckboxModel class >> viewName [
	^ 'CheckboxView'
]
