Class {
	#name : #DAPLaunchResquest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPLaunchResquest >> initialize [
	super initialize.
	command := 'launch'
]
