Class {
	#name : #IPSelectionSliderModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPSelectionSliderModel class >> modelName [
	^ 'SelectionSliderModel'
]

{ #category : #'instance creation' }
IPSelectionSliderModel class >> newInstance [
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
				#_options_labels -> {}.	
				#_options_values -> {}.
				#_dom_classes -> {}.
				#continuous_update -> true.
				#description -> ''.
				#description_tooltip -> nil.
				#disabled -> false.
				#layout -> nil.
				#index -> nil.
				#msg_throttle -> 1.
				#orientation -> 'horizontal'.
				#readout -> true.
				#style -> nil.
				#value -> nil	} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPSelectionSliderModel class >> viewName [
	^ 'SelectionSliderView'
]
