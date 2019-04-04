Class {
	#name : #IPWidgetModel,
	#superclass : #IPCoreWidgetModelGenerator,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPWidgetModel class >> modelName [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPWidgetModel class >> viewName [
	^self subclassResponsibility 
]
