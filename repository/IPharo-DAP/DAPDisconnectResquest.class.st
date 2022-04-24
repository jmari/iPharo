Class {
	#name : #DAPDisconnectResquest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDisconnectResquest >> initialize [
	super initialize.
	command := 'disconnect'
]
