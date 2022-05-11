"
I'm a message processor for the iopub subscriber channel, I process messages comming from the ioPub socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.

"
Class {
	#name : #IPIOPubSubscriberProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core-Processors'
}

{ #category : #hooks }
IPIOPubSubscriberProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	self handleRequest: message.	

	
]

{ #category : #initialization }
IPIOPubSubscriberProcessor >> initialize [ 
	super initialize. 	
	self addHandlersFromPragmasIn: IPIOPubSubscriberMsgHandler new.
]

{ #category : #accessing }
IPIOPubSubscriberProcessor >> threadName [
	^'ipharo-proxy-subscriber'
]
