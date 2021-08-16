Class {
	#name : #IPKernelStatusBusyMsg,
	#superclass : #IPKernelStatusMsg,
	#category : #'IPharo-Messages-IOPub'
}

{ #category : #'as yet unclassified' }
IPKernelStatusBusyMsg >> executionState [
	^ #busy
]
