Class {
	#name : #IPIntProgressModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPIntProgressModel class >> modelName [
	^ 'IntProgressModel'
]

{ #category : #'instance creation' }
IPIntProgressModel class >> newInstance [
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
				#max -> 100.
				#min -> 0.
				#msg_throttle -> 1.
				#orientation -> 'horizontal'. "'horizontal', 'vertical'"
				#step ->  1.
				#style ->  nil. "reference to ProgressStyle widget"
				#value -> 0.} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPIntProgressModel class >> viewName [
	^ 'ProgressView'
]
