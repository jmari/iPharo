Class {
	#name : #IPToggleButtonsStyleModel,
	#superclass : #IPStyleModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPToggleButtonsStyleModel class >> modelName [
	^ 'ToggleButtonsStyleModel'
]

{ #category : #'instance creation' }
IPToggleButtonsStyleModel class >> newInstance [
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
				#button_width -> ''.
				#description_width -> ''.
				#font_weight -> ''.
				} asSCJsonObject }.
]
