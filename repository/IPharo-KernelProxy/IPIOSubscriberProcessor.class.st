Class {
	#name : #IPIOSubscriberProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #hooks }
IPIOSubscriberProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	message inspect.
	session := IPSession getSessionForMessage: message.
	self handleRequest: message.	

	
]

{ #category : #accessing }
IPIOSubscriberProcessor >> threadName [
	^'ipharo-proxy-subscriber'
]
