Class {
	#name : #IPButtonStyleModel,
	#superclass : #IPStyleModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPButtonStyleModel class >> modelName [
	^ 'ButtonStyleModel'
]

{ #category : #'instance creation' }
IPButtonStyleModel class >> newInstance [
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
				#button_color -> nil.
				#font_weight -> ''.
				#msg_throttle -> 1.
				} asSCJsonObject }.
]
