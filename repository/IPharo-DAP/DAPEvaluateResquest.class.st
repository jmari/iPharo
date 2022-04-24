Class {
	#name : #DAPEvaluateResquest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPEvaluateResquest >> initialize [
	super initialize.
	command := 'evaluate'
]
