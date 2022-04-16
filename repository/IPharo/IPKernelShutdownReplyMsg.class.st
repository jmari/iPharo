Class {
	#name : #IPKernelShutdownReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Control'
}

{ #category : #initialization }
IPKernelShutdownReplyMsg >> initialize [
	super initialize.
	self msgType: #shutdown_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {
		#status->#ok.
		#restart->false} asSCJsonObject. 
]
