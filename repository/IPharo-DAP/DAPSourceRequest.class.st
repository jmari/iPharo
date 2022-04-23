Class {
	#name : #DAPSourceRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPSourceRequest >> initialize [
	super initialize.
	command := 'source'
]
