Class {
	#name : #IPIntSliderModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPIntSliderModel class >> modelName [
	^ 'IntSliderModel'
]

{ #category : #'instance creation' }
IPIntSliderModel class >> newInstance [
	^ self fromAssociations: 
		{	'version_major'-> self majorVersion.
			'version_minor'-> self minorVersion.
			'state'->{
				#_model_module -> self moduleName. 
				#_model_module_version -> self version.
				#_model_name -> self modelName.
				#_range -> true.
				#_view_module -> self moduleName.
				#_view_module_version -> self version.
				#_view_name -> self viewName.
				#_dom_classes -> {}.
				#continuous_update -> false.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled ->  false.
				#layout -> nil.
				#max -> 100.
				#min -> 0.
				#msg_throttle -> 1.
				#orientation -> 'horizontal'.
				#readout -> true.
				#readout_format -> 'd'.
				#step -> 1.
				#style -> nil.
				#value -> 0} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPIntSliderModel class >> viewName [
	^ 'IntSliderView'
]
