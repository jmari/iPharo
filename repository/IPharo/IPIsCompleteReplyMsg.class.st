Class {
	#name : #IPIsCompleteReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPIsCompleteReplyMsg >> initialize [
	super initialize.
	self msgType: #is_complete_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#status->#complete} asSCJsonObject . 

]
