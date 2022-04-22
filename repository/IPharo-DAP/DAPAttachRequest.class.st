Class {
	#name : #DAPAttachRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPAttachRequest >> initialize [
	super initialize.
	command := 'attach'
]
