Class {
	#name : #IPExecuteRequestReplyMsg,
	#superclass : #IPMsg,
	#instVars : [
		'sequenceNumber'
	],
	#category : #'IPharo-Messages-Shell'
}

{ #category : #'instance creation' }
IPExecuteRequestReplyMsg class >> newWithSequenceNumber: aSeqNum [
	^ self basicNew 
				executionCount: aSeqNum;
				initialize
]

{ #category : #accessing }
IPExecuteRequestReplyMsg >> executionCount [
	^ self content execution_count
]

{ #category : #accessing }
IPExecuteRequestReplyMsg >> executionCount: anInteger [
	self content execution_count: anInteger
]

{ #category : #initialization }
IPExecuteRequestReplyMsg >> initialize [
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
IPExecuteRequestReplyMsg >> status [
	self subclassResponsibility 	
]
