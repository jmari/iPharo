Class {
	#name : #IPKernelStatusBusyMsg,
	#superclass : #IPKernelStatusMsg,
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #'as yet unclassified' }
IPKernelStatusBusyMsg >> executionState [
	^ #busy
]
