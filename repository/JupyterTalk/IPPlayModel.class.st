Class {
	#name : #IPPlayModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPPlayModel class >> modelName [
	^ 'PlayModel'
]

{ #category : #'instance creation' }
IPPlayModel class >> newInstance [
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
				#_playing->false.
				#_repeat -> false.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled	-> false.
				#interval	 -> 100.
 				#layout	-> nil.
				#max	-> 100.
				#min -> 0.
				#show_repeat -> true.
				#msg_throttle -> 1.
				#step	-> 1.
				#style -> nil.
				#value	 -> 0} asSCJsonObject }
]

{ #category : #'as yet unclassified' }
IPPlayModel class >> viewName [
	^ 'PlayView'
]
