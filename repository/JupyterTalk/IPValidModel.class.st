Class {
	#name : #IPValidModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPValidModel class >> modelName [
	^ 'ValidModel'
]

{ #category : #'instance creation' }
IPValidModel class >> newInstance [
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
				#readout -> 'Invalid'.
				#style -> nil.
				#value -> false	} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPValidModel class >> viewName [
	^ 'ValidView'
]
