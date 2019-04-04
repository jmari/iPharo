Class {
	#name : #IPKernelStatusMsg,
	#superclass : #IPMsg,
	#instVars : [
		'sequenceNumber'
	],
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #accessing }
IPKernelStatusMsg >> executionState [
	self subclassResponsibility 	
]

{ #category : #initialization }
IPKernelStatusMsg >> initialize [
	super initialize.
	self msgType: #status.
	self metadata: SCJsonObject new.
	self parentHeader: '{}' asByteArray. 
	self content: { 
						#execution_state -> self executionState.
						} asSCJsonObject.

]
