Class {
	#name : #IPInputReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-StdIn'
}

{ #category : #'as yet unclassified' }
IPInputReplyMsg >> contentValue [
	^ self content at:#value
]

{ #category : #initialization }
IPInputReplyMsg >> initialize [
	super initialize.
	self msgType: #input_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#value-> ''} asSCJsonObject. 
]
