Class {
	#name : #DAPContinueRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPContinueRequest >> initialize [
	super initialize.
	command := 'continue'
]
