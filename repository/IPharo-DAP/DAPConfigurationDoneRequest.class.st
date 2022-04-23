Class {
	#name : #DAPConfigurationDoneRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPConfigurationDoneRequest >> initialize [
	super initialize.
	command := 'configurationDone'
]
