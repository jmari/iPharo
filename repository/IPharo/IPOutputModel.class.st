Class {
	#name : #IPOutputModel,
	#superclass : #IPDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPOutputModel class >> modelName [
	^ 'OutputModel'
]

{ #category : #'instance creation' }
IPOutputModel class >> newInstance [
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
				#layout -> nil.
				#msg_id -> ''.	
				#outputs -> ''.
				#msg_throttle -> 1} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPOutputModel class >> viewName [
	^ 'OutputView'
]
