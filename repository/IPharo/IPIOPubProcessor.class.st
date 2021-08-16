Class {
	#name : #IPIOPubProcessor,
	#superclass : #IPMessageProcessor,
	#category : #'IPharo-Core'
}

{ #category : #running }
IPIOPubProcessor >> execute: aWireMessage [
	| message |

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg newReplyingToWireMessage: aWireMessage).
	"Com messaging protocol, handlers are implemented in super because Shell also use them"
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	
	message msgType = #update_state ifTrue:[ self executeUpdateState: message].	
	message msgType = #request_state ifTrue:[ self executeUpdateState: message].
		
	self publish:  (IPKernelStatusIdleMsg newReplyingToWireMessage: aWireMessage).
]

{ #category : #'as yet unclassified' }
IPIOPubProcessor >> publish: anIPMessage [
	| aMessage |
	aMessage := IPWireMessage newFromMessage: anIPMessage.
	self zmqSocket  
				send: ('kernel.',anIPMessage uuid asString ,'.',anIPMessage msgType) asByteArray  flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage header flags:ZmqApiConstants  zmqSendMore;
				send: aMessage parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage metadata flags:ZmqApiConstants  zmqSendMore;
				send: aMessage content  
]

{ #category : #'as yet unclassified' }
IPIOPubProcessor >> receiveWireMessage [
	"Do nothing, it is the publisher"
		Processor yield.
		(Delay forMilliseconds: 500) wait.
]

{ #category : #'as yet unclassified' }
IPIOPubProcessor >> startingMessage [
	^  IPKernelStatusStartingMsg new
]

{ #category : #accessing }
IPIOPubProcessor >> threadName [
	^ 'ipharo-IOPub' 
]

{ #category : #'as yet unclassified' }
IPIOPubProcessor >> threadStarted [
	self publish: self startingMessage
]
