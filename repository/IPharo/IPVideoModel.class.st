Class {
	#name : #IPVideoModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPVideoModel class >> modelName [
	^ 'VideoModel'
]

{ #category : #'instance creation' }
IPVideoModel class >> newInstance [
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
				#autoplay -> true.
				#controls -> true.
				#format	-> 'mp4'.
				#height	 -> ''.
 				#layout	-> nil.
				#loop	-> true.
				#value	 -> 'b'''''.
				#width -> ''.
					} asSCJsonObject }
]

{ #category : #'as yet unclassified' }
IPVideoModel class >> viewName [
	^ 'VideoView'
]
