Class {
	#name : #IPDebugReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Control'
}

{ #category : #initialization }
IPDebugReplyMsg >> initialize [
	super initialize.
	self msgType: #debug_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {} asSCJsonObject. 
]
