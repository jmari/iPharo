Class {
	#name : #IPMessageProcessor,
	#superclass : #Object,
	#instVars : [
		'zmqSocket',
		'stop',
		'wireMessage',
		'handlers',
		'sharedKey'
	],
	#category : #'IPharo-Core'
}

{ #category : #'instance creation' }
IPMessageProcessor class >> new: aZmqSocket [
	| i |
	i :=	self new.
	i zmqSocket: aZmqSocket.
	^ i startThread 
]

{ #category : #'instance creation' }
IPMessageProcessor class >> new: aZmqSocket sharedKey: sharedKeyString [
	| i |
	i :=	self new.
	i zmqSocket: aZmqSocket.
	i sharedKey: sharedKeyString.
	^ i startThread 
]

{ #category : #'message-handlers' }
IPMessageProcessor >> addHandler: aDAPHandler [
	handlers add: aDAPHandler
]

{ #category : #'message-handlers' }
IPMessageProcessor >> addHandlersFromPragmasIn: handlerInstance [
	self addHandlersFromPragmasInClass: handlerInstance class handlerInstance:handlerInstance
		
]

{ #category : #'message-handlers' }
IPMessageProcessor >> addHandlersFromPragmasInClass: class handlerInstance: handlerInstance [ 
	(Pragma allNamed: #ipharo: in: class)
		do: [ :pragma | 
			self
				addHandler:
					(IPHandler new
						receiver: handlerInstance;
						methodName: pragma arguments first;
						messageSelector: pragma methodSelector;
						yourself) ]
]

{ #category : #hooks }
IPMessageProcessor >> debug: anError [
	ZmqLog logDebug: anError asString 
]

{ #category : #hooks }
IPMessageProcessor >> execute: anIPMessage [
	self subclassResponsibility 
]

{ #category : #'message-handlers' }
IPMessageProcessor >> handleRequest: anIPMsg [
	[ | handler |
	handler := self handlerFor: anIPMsg.
	handler executeWithArguments: anIPMsg ]
		on: Error
		do: [ :ipError | self debug: ipError ] 
]

{ #category : #'message-handlers' }
IPMessageProcessor >> handlerFor: aIPMsg [

	^ handlers
		detect: [ :handler | handler methodName = aIPMsg msgType ]
		ifNone: [ IPNonExistentHandler signal: aIPMsg msgType ]
]

{ #category : #initialize }
IPMessageProcessor >> initialize [ 
	super initialize.
	handlers := OrderedCollection new.
	self addHandlersFromPragmasIn: self.
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

	self wireMessage isFull ifFalse:[ ^ self ].
	response := self wireMessage hmacIsValid 
												ifTrue:[ self execute: self wireMessage ]
												ifFalse:[ IPHMACError signal:'Wrong HMAC' ].
	self wireMessage: IPWireMessage new.
]

{ #category : #'comm handlers' }
IPMessageProcessor >> publish: aResult [
	IPharoKernel instance publisher publish:  aResult 
]

{ #category : #parsing }
IPMessageProcessor >> pushMessageFrame:messageData [ 

	(messageData =  (self messageDelimiter asByteArray))
				ifTrue:[ self wireMessage delimiterReceived ]
				ifFalse:[ self wireMessage push:messageData ]

						
	

]

{ #category : #'as yet unclassified' }
IPMessageProcessor >> receiveWireMessage [
	|more|
	self zmqSocket receiveIfAvailable: [ :messageData|  
							more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore.
							messageData isEmpty 
							ifTrue:[							
									Processor yield.
									(Delay forMilliseconds: 500) wait ]
							ifFalse:[ self pushMessageFrame:messageData ].
							more = 0 ifTrue: [ self processMessage ] ].	
]

{ #category : #running }
IPMessageProcessor >> sendMessage: anIPResponse [
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

{ #category : #accessing }
IPMessageProcessor >> sharedKey [ 
	^ sharedKey ifNil:[ sharedKey := IPharoKernel instance sharedKey ]
]

{ #category : #accessing }
IPMessageProcessor >> sharedKey: sharedKeyString [ 
	sharedKey := sharedKeyString
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
			] forkAt: Processor systemBackgroundPriority named: self threadName
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
	"shared key is only setted by a kernelProxy, otherwise is nil 
	 so that wireMessage hmac calculation is done using the Kernel (IPharoKernel) 
	 shared key "
	wireMessage := aWireMessage.
	wireMessage sharedKey: self sharedKey
]

{ #category : #accessing }
IPMessageProcessor >> zmqSocket [
	^ zmqSocket
		
]

{ #category : #accessing }
IPMessageProcessor >> zmqSocket: aZmqSocket [
	zmqSocket := aZmqSocket
		
]
