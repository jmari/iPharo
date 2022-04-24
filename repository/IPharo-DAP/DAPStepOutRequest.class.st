Class {
	#name : #DAPStepOutRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPStepOutRequest >> initialize [
	super initialize.
	command := 'stepOut'
]
