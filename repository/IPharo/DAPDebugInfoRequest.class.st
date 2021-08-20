Class {
	#name : #DAPDebugInfoRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDebugInfoRequest >> initialize [
	super initialize.
	command := 'debugInfo'
]
