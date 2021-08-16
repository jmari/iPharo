Class {
	#name : #IPImageModel,
	#superclass : #IPDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPImageModel class >> modelName [
	^ 'ImageModel'
]

{ #category : #'instance creation' }
IPImageModel class >> newInstance [
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
				#format ->'png'.
				#height -> ''.
				#layout -> nil.
				#msg_throttle -> 1.
				#value -> 'b'''''.
				#width -> ''} asSCJsonObject }.
				
]

{ #category : #'as yet unclassified' }
IPImageModel class >> viewName [
	^ 'ImageView'
]
