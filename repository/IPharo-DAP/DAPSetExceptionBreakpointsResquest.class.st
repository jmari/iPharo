Class {
	#name : #DAPSetExceptionBreakpointsResquest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPSetExceptionBreakpointsResquest >> initialize [
	super initialize.
	command := 'setExceptionBreakpoints'
]
