Class {
	#name : #IPCommInfoReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPCommInfoReplyMsg >> initialize [
	super initialize.
	self msgType: #comm_info_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#comms -> IPharoKernel instance commManager commChannels asSCJsonObject} asSCJsonObject. 

]
