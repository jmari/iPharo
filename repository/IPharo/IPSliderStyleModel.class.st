Class {
	#name : #IPSliderStyleModel,
	#superclass : #IPStyleModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPSliderStyleModel class >> modelName [
	^ 'SliderStyleModel'
]

{ #category : #'instance creation' }
IPSliderStyleModel class >> newInstance [
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
				#description_width -> ''.
				#handle_color -> nil.
				#msg_throttle -> 1.
				} asSCJsonObject }.
]
