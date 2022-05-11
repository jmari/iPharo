"
I'm a message processor for the ioPub channel, I process messages comming from the ioPub socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.

I'm the only publisher, all the published messages are sent by me, normally using the IPharoKernel publisher reference and #publish: anIPMessage. Due to this particularity I have to take care about multiple threads trying to send pub messages, there is a mutex to avoid colisions 

"
Class {
	#name : #IPIOPublisherProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'mutex'
	],
	#category : #'IPharo-Core'
}

{ #category : #running }
IPIOPublisherProcessor >> execute: aWireMessage [
	| message |

	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		
]

{ #category : #initialization }
IPIOPublisherProcessor >> initialize [ 
	super initialize.
	mutex := Mutex new
]

{ #category : #'as yet unclassified' }
IPIOPublisherProcessor >> publish: anIPMessage [
	"publish is called from different threads that get the reference through 
	IPharoKernel instance publisher so we sould take care of sending	 a message 
	in the correct sequencial order. This message overrides the default publish call
	who actually calls this same message but always on the same publisher instance"
	| aMessage |
	anIPMessage inspect.
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
IPIOPublisherProcessor >> receiveWireMessage [
	"Do nothing, it is the publisher"
		Processor yield.
		(Delay forMilliseconds: 500) wait.
]

{ #category : #'as yet unclassified' }
IPIOPublisherProcessor >> startingMessage [
	^  IPKernelStatusStartingMsg new
]

{ #category : #accessing }
IPIOPublisherProcessor >> threadName [
	^ 'ipharo-IOPub' 
]

{ #category : #'as yet unclassified' }
IPIOPublisherProcessor >> threadStarted [
	self publish: self startingMessage
]
