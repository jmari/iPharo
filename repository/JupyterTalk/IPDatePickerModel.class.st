Class {
	#name : #IPDatePickerModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPDatePickerModel class >> modelName [
	^ 'DatePickerModel'
]

{ #category : #'instance creation' }
IPDatePickerModel class >> newInstance [
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
				#description_tooltip ->nil.
				#layout -> nil.
				#disabled -> false.
				#style -> nil.
				#msg_throttle -> 1.
				#value -> Date today
			} asSCJsonObject }.
]

{ #category : #'instance creation' }
IPDatePickerModel class >> viewName [
	^ 'DatePickerView'
]
