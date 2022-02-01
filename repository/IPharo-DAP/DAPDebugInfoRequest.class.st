Class {
	#name : #DAPDebugInfoRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDebugInfoRequest >> initialize [
	super initialize.
	command := 'debugInfo'
]
