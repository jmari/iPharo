Class {
	#name : #IPIOPubProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'mutex'
	],
	#category : #'IPharo-Core'
}

{ #category : #running }
IPIOPubProcessor >> execute: aWireMessage [
	| message |

	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		
]

{ #category : #initialization }
IPIOPubProcessor >> initialize [ 
	super initialize.
	mutex := Mutex new
]

{ #category : #'as yet unclassified' }
IPIOPubProcessor >> publish: anIPMessage [
	"publish is called from different threads that get the reference through 
	IPharoKernel instance publisher so we sould take care of sending	 a message 
	in the correct sequencial order. This message overrides the default publish call
	who actually calls this same message but always on the same publisher instance"
	| aMessage |
	
	aMessage := IPWireMessage newFromMessage: anIPMessage.
	mutex critical:[
	self zmqSocket  
				send: ('kernel.',anIPMessage uuid asString ,'.',anIPMessage msgType) asByteArray  flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage header flags:ZmqApiConstants  zmqSendMore;
				send: aMessage parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage metadata flags:ZmqApiConstants  zmqSendMore;
				send: aMessage content ]
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
