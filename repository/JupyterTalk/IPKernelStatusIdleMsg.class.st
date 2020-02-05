Class {
	#name : #IPKernelStatusIdleMsg,
	#superclass : #IPKernelStatusMsg,
	#category : #'JupyterTalk-Messages-IOPub'
}

{ #category : #'as yet unclassified' }
IPKernelStatusIdleMsg >> executionState [
	^ #idle
]
