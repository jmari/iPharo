Class {
	#name : #IPLinkModel,
	#superclass : #IPWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPLinkModel class >> modelName [
	^ 'LinkModel'
]

{ #category : #'instance creation' }
IPLinkModel class >> newInstance [
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
IPLinkModel class >> viewName [
	^ nil
]
