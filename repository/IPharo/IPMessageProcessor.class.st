"
I'm a message processor, I process messages comming from a ZmqSocket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message. 

For the Class part:  Initialization is done by #new:aZmqSocket or #new:aZmqSocket sharedKey: a string. The IPharoKernel has one processor per socket. They are created by #new:socket (sharedKey is not assigned) so when my thread receives a new message and stores it in the state using #wireMessage: the sharedKey will be nil. A wireMessage uses this key to calculate the hmac, if the key is nil, it uses the IPharoKernel key established on the kernel startup process. 

I'm responsible of message processing, requesting a message and responding using a handler.

My subclasses declare their handlers, there is one subcless per socket
"
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
   | collectionOfHandlers |
	[collectionOfHandlers := self handlerFor: anIPMsg.
	 collectionOfHandlers do:[ :aHandler |
		aHandler executeWithArguments: anIPMsg ] ]
		on: Error
		do: [ :ipError | self debug: ipError ] 
]

{ #category : #'message-handlers' }
IPMessageProcessor >> handlerFor: aIPMsg [
	| collectionOfHandlers |
	collectionOfHandlers := handlers
		select:  [ :handler | handler methodName = aIPMsg msgType ].
	collectionOfHandlers isEmpty ifTrue: [ IPNonExistentHandler signal: aIPMsg msgType ].
	^ collectionOfHandlers
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
