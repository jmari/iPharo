Class {
	#name : #IPBoundedFloatTextModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPBoundedFloatTextModel class >> modelName [
	^ 'FloatTextModel'
]

{ #category : #'instance creation' }
IPBoundedFloatTextModel class >> newInstance [
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
				#max -> 100.0.
				#min -> 0.0.
				#step -> nil.
				#style -> nil.
				#value -> 0.0} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPBoundedFloatTextModel class >> viewName [
	^ 'FloatTextView'
]
