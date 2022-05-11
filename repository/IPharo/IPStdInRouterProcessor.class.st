"
I'm a message processor for the stdin channel, I process messages comming from the stdin socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.

I handle imput replay message 
"
Class {
	#name : #IPStdInRouterProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-Core'
}

{ #category : #hooks }
IPStdInRouterProcessor >> execute: aWireMessage [
	| message |
	
	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		
]

{ #category : #'as yet unclassified' }
IPStdInRouterProcessor >> executeInputReplay: aMessage [
	<ipharo: #input_reply>
	
	| session |
	session := IPSession session: aMessage header session.
	session acceptInputReplay: (aMessage content at:#value)
]

{ #category : #accessing }
IPStdInRouterProcessor >> threadName [
	^ 'ipharo-stdin' 
]
