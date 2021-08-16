Class {
	#name : #IPWidgetModel,
	#superclass : #IPCoreWidgetModelGenerator,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPWidgetModel class >> modelName [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPWidgetModel class >> viewName [
	^self subclassResponsibility 
]
