Class {
	#name : #DAPRichInspectVariablesRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPRichInspectVariablesRequest >> initialize [
	super initialize.
	command := 'richInspectVariables'
]
