Class {
	#name : #IPDirectionalLinkModel,
	#superclass : #IPDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPDirectionalLinkModel class >> modelName [
	^ 'DirectionalLinkModel'
]

{ #category : #'instance creation' }
IPDirectionalLinkModel class >> newInstance [
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
				#msg_throttle -> 1.
				#source -> {}.
				#target -> {}	} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPDirectionalLinkModel class >> viewName [
	^ nil
]
