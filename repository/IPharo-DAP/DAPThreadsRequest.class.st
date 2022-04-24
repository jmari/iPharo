Class {
	#name : #DAPThreadsRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPThreadsRequest >> initialize [
	super initialize.
	command := 'threads'
]
