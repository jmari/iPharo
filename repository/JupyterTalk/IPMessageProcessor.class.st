Class {
	#name : #IPMessageProcessor,
	#superclass : #Object,
	#instVars : [
		'zmqSocket',
		'stop',
		'wireMessage'
	],
	#category : #'JupyterTalk-Core'
}

{ #category : #'instance creation' }
IPMessageProcessor class >> new: aZmqSocket [
	| i |
	i :=	self new.
	i zmqSocket: aZmqSocket.
	^ i startThread 
]

{ #category : #hooks }
IPMessageProcessor >> debug: anError [
	ZmqLog logDebug: anError asString 
]

{ #category : #hooks }
IPMessageProcessor >> execute: anIPMessage [
	self subclassResponsibility 
]

{ #category : #widgetMessages }
IPMessageProcessor >> executeCommCloseRequest: aMessage [
	IPharoKernel instance commManager unregisterComm: (aMessage content at:#comm_id).
	
	"NO-RESPONSE"
]

{ #category : #widgetMessages }
IPMessageProcessor >> executeCommMsgRequest: aMessage [ 
	| comm data |
	                   
	comm :=(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)). 
	data := aMessage content at:#data.
	(data at:#method) = 'update' ifTrue:[ comm commListeners do:[:l| l updateState:(data at:#state)]].
	(data at:#method) = 'request_state' ifTrue:[ comm commListeners 
		do:[:l| comm update:l model state]].	 

]

{ #category : #widgetMessages }
IPMessageProcessor >> executeCommOpenRequest: aMessage [
	IPComm new:(aMessage content at:#comm_id).

	"NO-RESPONSE"

	
	

]

{ #category : #widgetMessages }
IPMessageProcessor >> executeRequestState: aMessage [ 

	                   
	(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)) 
	commListeners do:[:aMsgHandler|
		aMsgHandler comm update: aMsgHandler model state].
]

{ #category : #widgetMessages }
IPMessageProcessor >> executeUpdateState: aMessage [ 
	| response |                
	(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)) commListeners  
	 do:[:aListener|
		response := aListener model state: (aMessage content at:#state)]
]

{ #category : #testing }
IPMessageProcessor >> isStopping [
	^ stop ifNil:[stop:=false]
]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> messageDelimiter [ 
	^'<IDS|MSG>'
]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> processMessage [
	|response|
	self wireMessage isFull ifTrue:[

	response := self wireMessage hmacIsValid 
												ifTrue:[self execute: self wireMessage]
												ifFalse:[IPHMACException signal:'Wrong HMAC'].

	self wireMessage: IPWireMessage new].


						
	

]

{ #category : #'comm handlers' }
IPMessageProcessor >> publish: aResult [
	| iopub |
	iopub := (IPharoKernel instance processors at:#iopub ifAbsent:[nil]). 
	iopub 
			ifNil:[ self debug: aResult asString ]
			ifNotNil:[ iopub publish:  aResult ]
]

{ #category : #parsing }
IPMessageProcessor >> pushMessageFrame:messageData [ 
	Transcript show: '-', messageData asString;cr.
	(messageData =  (self messageDelimiter asByteArray))
				ifFalse:[ self wireMessage push:messageData ]

						
	

]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> receiveWireMessage [
	|more|
	self zmqSocket receiveIfAvailable: [ :messageData|  
							more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore.
							messageData size > 0 
							ifTrue:[self pushMessageFrame:messageData]
							ifFalse:[							
									Processor yield.
									(Delay forMilliseconds: 500) wait].
							more = 0 ifTrue: [ self processMessage ]].	
]

{ #category : #running }
IPMessageProcessor >> respond: anIPResponse [
	| aResponse |
	aResponse := IPWireMessage newFromMessage: anIPResponse.
	self zmqSocket ifNotNil: [ 
		self zmqSocket  
				send: aResponse uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse header flags:ZmqApiConstants  zmqSendMore;
				send: aResponse parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse metadata flags:ZmqApiConstants  zmqSendMore;
				send: aResponse content ]
]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> startThread [
	[	|more|
		self wireMessage: IPWireMessage new.
		self threadStarted.
		more := 1.
		[ self isStopping ] whileFalse:[
			self receiveWireMessage.
			Processor yield].
			] forkAt: Processor userSchedulingPriority named: self threadName
]

{ #category : #accessing }
IPMessageProcessor >> stop [
	stop := true
]

{ #category : #accessing }
IPMessageProcessor >> threadName [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> threadStarted [
	"do nothing"
]

{ #category : #accessing }
IPMessageProcessor >> wireMessage [
	^ wireMessage
]

{ #category : #private }
IPMessageProcessor >> wireMessage: aWireMessage [
	"only for testing"
	wireMessage := aWireMessage
]

{ #category : #accessing }
IPMessageProcessor >> zmqSocket [
	^ zmqSocket
		
]

{ #category : #accessing }
IPMessageProcessor >> zmqSocket: aZmqSocket [
	zmqSocket := aZmqSocket
		
]
