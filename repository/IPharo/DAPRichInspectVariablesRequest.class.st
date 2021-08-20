Class {
	#name : #DAPRichInspectVariablesRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-Messages-DAPSupport'
}

{ #category : #initialization }
DAPRichInspectVariablesRequest >> initialize [
	super initialize.
	command := 'richInspectVariables'
]
