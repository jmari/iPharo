Class {
	#name : #IPCompleteReplyMsg,
	#superclass : #IPMsg,
	#category : #'JupyterTalk-Messages-Shell'
}

{ #category : #initialization }
IPCompleteReplyMsg >> initialize [
	super initialize.
	self msgType: #complete_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new.

]
