Class {
	#name : #IPControllerButtonModel,
	#superclass : #IPDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPControllerButtonModel class >> modelName [
	^'ControllerButtonModel'
]

{ #category : #'instance creation' }
IPControllerButtonModel class >> newInstance [
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
				#msg_throttle -> 1.
				#layout -> nil.
				#pressed -> false.
				#value -> 0.0} asSCJsonObject }.
				
]

{ #category : #'as yet unclassified' }
IPControllerButtonModel class >> viewName [
	^'ControllerButtonView'
]
