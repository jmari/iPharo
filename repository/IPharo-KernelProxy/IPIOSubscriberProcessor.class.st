"
I'm a message processor for the iopub subscriber channel, I process messages comming from the ioPub socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.

"
Class {
	#name : #IPIOSubscriberProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #hooks }
IPIOSubscriberProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	message inspect.
	self handleRequest: message.	

	
]

{ #category : #accessing }
IPIOSubscriberProcessor >> threadName [
	^'ipharo-proxy-subscriber'
]
