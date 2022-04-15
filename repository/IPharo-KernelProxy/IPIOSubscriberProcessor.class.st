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
	self handleRequest: message.	

	
]

{ #category : #accessing }
IPIOSubscriberProcessor >> threadName [
	^'ipharo-proxy-subscriber'
]
