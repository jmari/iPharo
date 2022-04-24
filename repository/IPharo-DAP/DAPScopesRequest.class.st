Class {
	#name : #DAPScopesRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPScopesRequest >> initialize [
	super initialize.
	command := 'scopes'
]
