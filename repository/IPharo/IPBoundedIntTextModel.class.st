Class {
	#name : #IPBoundedIntTextModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPBoundedIntTextModel class >> modelName [
	^ 'IntTextModel'
]

{ #category : #'instance creation' }
IPBoundedIntTextModel class >> newInstance [
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
				#continuous_update -> false.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#layout -> nil.
				#max -> 100.
				#min -> 0.
				#step ->  1.
				#style -> nil.
				#value -> 0.
		} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPBoundedIntTextModel class >> viewName [
	^ 'IntTextView'
]
