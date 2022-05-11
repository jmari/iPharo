Class {
	#name : #IPShellDealerProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-KernelProxy-Core-Processors'
}

{ #category : #hooks }
IPShellDealerProcessor >> execute: aWireMessage [
	| message session|
	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	self handleRequest: message.	

	
]

{ #category : #initialization }
IPShellDealerProcessor >> initialize [ 
	super initialize. 	
	self addHandlersFromPragmasIn: IPShellMsgHandler new.
]

{ #category : #accessing }
IPShellDealerProcessor >> threadName [
	^'ipharo-proxy-dealer'
]
