Class {
	#name : #IPControllerModel,
	#superclass : #IPCoreWidgetModelGenerator,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPControllerModel class >> modelName [
	^'ControllerModel'
]

{ #category : #'instance creation' }
IPControllerModel class >> newInstance [
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
				#axes-> {}.
				#buttons-> {} .
				#connected-> false.
				#index-> 0.
				#layout -> nil.
				#mapping-> ''.
				#msg_throttle -> 1.
				#name -> ''.
				#timestamp -> 0.0} asSCJsonObject  }.
]

{ #category : #'instance creation' }
IPControllerModel class >> viewName [
	^'ControllerView'
]
