Class {
	#name : #IPDOMWidgetModel,
	#superclass : #IPWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPDOMWidgetModel class >> modelName [
	^ 'DomWidgetModel'
]

{ #category : #'instance creation' }
IPDOMWidgetModel class >> newInstance [
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
				#children -> {}.
				#layout -> nil.
				#value -> 'b'''''
				} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPDOMWidgetModel class >> viewName [
	^ nil.
]
