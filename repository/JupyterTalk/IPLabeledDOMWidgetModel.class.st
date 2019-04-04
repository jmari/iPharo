Class {
	#name : #IPLabeledDOMWidgetModel,
	#superclass : #IPDOMWidgetModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPLabeledDOMWidgetModel class >> modelName [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPLabeledDOMWidgetModel class >> viewName [
	^ self subclassResponsibility 
]
