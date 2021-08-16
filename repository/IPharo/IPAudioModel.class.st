Class {
	#name : #IPAudioModel,
	#superclass : #IPLabeledDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPAudioModel class >> modelName [
	^ 'AudioModel'
]

{ #category : #'instance creation' }
IPAudioModel class >> newInstance [
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
				#format -> 'mp3'.
				#layout -> nil.
				#loop -> true.
				#value -> 'b''''' 	
				} asSCJsonObject }.
]

{ #category : #'as yet unclassified' }
IPAudioModel class >> viewName [
	^ 'AudioView'
]
