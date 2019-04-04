Class {
	#name : #IPFloatRangeSliderModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPFloatRangeSliderModel class >> modelName [
	^ 'FloatRangeSliderModel'
]

{ #category : #'instance creation' }
IPFloatRangeSliderModel class >> newInstance [
	^ self fromAssociations: 
		{	'version_major'-> self majorVersion.
			'version_minor'-> self minorVersion.
			'state'->{
				#_model_module -> self moduleName. 
				#_model_module_version -> self version.
				#_model_name -> self modelName.
				#_range ->  false.
				#_view_module -> self moduleName.
				#_view_module_version -> self version.
				#_view_name -> self viewName.
				#_dom_classes -> {}.
				#continuous_update -> false.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled ->  false.
				#layout -> nil.
				#max -> 100.0.
				#min -> 0.0.
				#msg_throttle -> 1.
				#orientation -> 'horizontal'.
				#readout -> true.
				#readout_format ->'.2f'.
				#slider_color -> nil.	
				#step -> 0.1.
				#style -> nil.
				#value -> {0.0. 0.1.}.
			} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPFloatRangeSliderModel class >> viewName [
	^ 'FloatRangeSliderView'
]
