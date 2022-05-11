Class {
	#name : #IPStdInDealerProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core-Processors'
}

{ #category : #hooks }
IPStdInDealerProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	self handleRequest: message.	

	
]

{ #category : #initialization }
IPStdInDealerProcessor >> initialize [ 
	super initialize. 	
	self addHandlersFromPragmasIn: IPStdInMsgHandler new.
]

{ #category : #accessing }
IPStdInDealerProcessor >> threadName [
	^'ipharo-proxy-dealer'
]
