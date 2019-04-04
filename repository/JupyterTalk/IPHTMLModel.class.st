Class {
	#name : #IPHTMLModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPHTMLModel class >> modelName [
	^ 'HTMLModel'
]

{ #category : #'instance creation' }
IPHTMLModel class >> newInstance [
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
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#layout -> nil.
				#msg_throttle -> 1.
				#placeholder -> '\u200b'.
				#style -> nil.
				#value -> ''.	} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPHTMLModel class >> viewName [
	^ 'HTMLView'
]
