Class {
	#name : #IPProgressStyleModel,
	#superclass : #IPStyleModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPProgressStyleModel class >> modelName [
	^ 'ProgressStyleModel'
]

{ #category : #'instance creation' }
IPProgressStyleModel class >> newInstance [
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
				#bar_color ->nil.
				#description_width -> ''.
				} asSCJsonObject }.
]
