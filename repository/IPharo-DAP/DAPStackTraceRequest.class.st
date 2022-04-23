Class {
	#name : #DAPStackTraceRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPStackTraceRequest >> initialize [
	super initialize.
	command := 'stackTrace'
]
