Class {
	#name : #DAPInspectVariablesRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPInspectVariablesRequest >> initialize [
	super initialize.
	command := 'inspectVariables'
]
