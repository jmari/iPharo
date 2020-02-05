Class {
	#name : #IPExecuteRequestReplayMsg,
	#superclass : #IPMsg,
	#instVars : [
		'sequenceNumber'
	],
	#category : #'JupyterTalk-Messages-Shell'
}

{ #category : #'instance creation' }
IPExecuteRequestReplayMsg class >> newWithSequenceNumber: aSeqNum [
	^ self basicNew 
				executionCount: aSeqNum;
				initialize
]

{ #category : #accessing }
IPExecuteRequestReplayMsg >> executionCount [
	^ self content execution_count
]

{ #category : #accessing }
IPExecuteRequestReplayMsg >> executionCount: anInteger [
	self content execution_count: anInteger
]

{ #category : #initialization }
IPExecuteRequestReplayMsg >> initialize [
	super initialize.
	self msgType: #execute_reply.
	self parentHeader: '{}' asByteArray .
	self metadata:{ 
						#dependencies_met->true.
						#started-> DateAndTime now asString.
						#status -> self status.
						} asSCJsonObject.
	self content: { 
						#status -> self status.
						} asSCJsonObject.

]

{ #category : #accessing }
IPExecuteRequestReplayMsg >> status [
	self subclassResponsibility 	
]
