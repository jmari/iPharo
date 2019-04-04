Class {
	#name : #IPAccordionModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPAccordionModel class >> modelName [
	^ 'AccordionModel'
]

{ #category : #'instance creation' }
IPAccordionModel class >> newInstance [
	^ self fromAssociations: 
		{	'version_major'-> self majorVersion.
			'version_minor'-> self minorVersion.
			'state'->{
				#_model_module -> self moduleName. 
				#_model_module_version -> self version.
				#_model_name -> self modelName.
				#_titles -> {}.
				#_view_module -> self moduleName.
				#_view_module_version -> self version.
				#_view_name -> self viewName.
				#_dom_classes -> {}.
				#box_style -> ''. "'success', 'info', 'warning', 'danger', ''"
				#children -> {}.
				#layout -> nil.
				#selected_index -> 0.	
				} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPAccordionModel class >> viewName [
	^ 'AccordionView'
]
