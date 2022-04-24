Class {
	#name : #DAPStepInRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPStepInRequest >> initialize [
	super initialize.
	command := 'stepIn'
]
