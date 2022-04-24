Class {
	#name : #DAPNextRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPNextRequest >> initialize [
	super initialize.
	command := 'next'
]
