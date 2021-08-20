Class {
	#name : #DAPInspectVariablesRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-Messages-DAPSupport'
}

{ #category : #initialization }
DAPInspectVariablesRequest >> initialize [
	super initialize.
	command := 'inspectVariables'
]
