Class {
	#name : #IPSelectModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPSelectModel class >> modelName [
	^ 'SelectModel'
]

{ #category : #'instance creation' }
IPSelectModel class >> newInstance [
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
				#_options_labels -> {}.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#index -> nil.
				#layout -> nil.
				#msg_throttle -> 1.
				#rows -> 5.
				#style -> nil.
				#value -> nil } asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPSelectModel class >> viewName [
	^ 'SelectView'
]
