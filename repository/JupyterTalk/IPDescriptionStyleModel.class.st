Class {
	#name : #IPDescriptionStyleModel,
	#superclass : #IPStyleModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPDescriptionStyleModel class >> modelName [
	^ 'ButtonStyleModel'
]

{ #category : #'instance creation' }
IPDescriptionStyleModel class >> newInstance [
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
				#description_width -> nil.
				#msg_throttle -> 1.
				} asSCJsonObject }.
]
