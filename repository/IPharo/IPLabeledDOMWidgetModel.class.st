Class {
	#name : #IPLabeledDOMWidgetModel,
	#superclass : #IPDOMWidgetModel,
	#category : #'IPharo-Widgets'
}

{ #category : #'as yet unclassified' }
IPLabeledDOMWidgetModel class >> modelName [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPLabeledDOMWidgetModel class >> viewName [
	^ self subclassResponsibility 
]
