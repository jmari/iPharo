Class {
	#name : #IPInterruptReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Control'
}

{ #category : #initialization }
IPInterruptReplyMsg >> initialize [
	super initialize.
	self msgType: #interrupt_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#status->#ok} asSCJsonObject. 
]
