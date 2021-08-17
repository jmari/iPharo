Class {
	#name : #IPStdInProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-Core'
}

{ #category : #hooks }
IPStdInProcessor >> execute: aWireMessage [
	| message |
	
	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		
]

{ #category : #'as yet unclassified' }
IPStdInProcessor >> executeInputReplay: aMessage [
	<ipharo: #input_reply>
	
	| session |
	session := IPSession session: aMessage header session.
	session acceptInputReplay: (aMessage content at:#value)
]

{ #category : #accessing }
IPStdInProcessor >> threadName [
	^ 'ipharo-stdin' 
]
