Class {
	#name : #IPFloatProgressModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPFloatProgressModel class >> modelName [
	^'FloatProgressModel'
]

{ #category : #'instance creation' }
IPFloatProgressModel class >> newInstance [
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
				#bar_style -> ''.	"'success', 'info', 'warning', 'danger', ''"
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#layout -> nil.
				#max -> 100.0.
				#min -> 0.0.
				#msg_throttle -> 1.
				#orientation -> 'horizontal'. "'horizontal', 'vertical'"
				#style ->  nil. "reference to ProgressStyle widget"
				#value -> 0.0.
			} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPFloatProgressModel class >> viewName [
	^'ProgressView'
]
