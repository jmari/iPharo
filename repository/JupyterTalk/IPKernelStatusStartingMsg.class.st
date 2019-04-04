Class {
	#name : #IPKernelStatusStartingMsg,
	#superclass : #IPKernelStatusMsg,
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #'as yet unclassified' }
IPKernelStatusStartingMsg >> executionState [
	^ #starting
]
