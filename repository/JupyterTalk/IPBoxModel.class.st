Class {
	#name : #IPBoxModel,
	#superclass : #IPDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPBoxModel class >> modelName [
	^ 'BoxModel'
]

{ #category : #'instance creation' }
IPBoxModel class >> newInstance [
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
				#box_style -> ''. "'success', 'info', 'warning', 'danger', ''"
				#children -> {}.
				#layout -> nil.
				} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPBoxModel class >> viewName [
	^ 'ViewBox'
]
