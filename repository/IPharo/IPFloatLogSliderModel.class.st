Class {
	#name : #IPFloatLogSliderModel,
	#superclass : #IPFloatSliderModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPFloatLogSliderModel class >> modelName [
	^ 'FloatLogSliderModel'
]

{ #category : #'instance creation' }
IPFloatLogSliderModel class >> newInstance [
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
				#base -> 10.
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
				#value -> 0.0. 
			} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPFloatLogSliderModel class >> viewName [
	^ 'FloatLogSliderView'
]
