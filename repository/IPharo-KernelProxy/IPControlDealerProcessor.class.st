Class {
	#name : #IPControlDealerProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core-Processors'
}

{ #category : #hooks }
IPControlDealerProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	self handleRequest: message.	

	
]

{ #category : #initialization }
IPControlDealerProcessor >> initialize [ 
	super initialize. 	
	self addHandlersFromPragmasIn: IPControlMsgHandler new.
]

{ #category : #accessing }
IPControlDealerProcessor >> threadName [
	^'ipharo-proxy-dealer'
]
