Class {
	#name : #DAPSetBreakpointsRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPSetBreakpointsRequest >> initialize [
	super initialize.
	command := 'setBreakpoints'
]
