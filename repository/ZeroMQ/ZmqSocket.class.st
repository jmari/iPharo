Class {
	#name : #ZmqSocket,
	#superclass : #Object,
	#instVars : [
		'socketPointer',
		'context',
		'associations',
		'parked',
		'monitor',
		'resultHandler',
		'dataAvailable'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqSocket class >> context: aZmqContext [
	^super new context:  aZmqContext; yourself.
]

{ #category : #'as yet unclassified' }
ZmqSocket class >> createSocketCreationMethodToContext [
	(self class methodDict at: #socketType) isAbstract
		ifFalse: [ 
			ZmqContext
				compileSilently: self name asString uncapitalized  , '^ self newSocket:' , self name asString
				classified: #'socket creation'
				notifying: nil ]
]

{ #category : #'class initialization' }
ZmqSocket class >> initialize [
	super initialize.
	self createSocketCreationMethodToContext.
]

{ #category : #'as yet unclassified' }
ZmqSocket class >> initializeAllSubclasses [
	self subclasses do: [:subclass| subclass initialize].
]

{ #category : #'as yet unclassified' }
ZmqSocket class >> new [
	^ZmqContext current newSocket: self.
]

{ #category : #'as yet unclassified' }
ZmqSocket class >> socketPointer: socketPointer inContext: aZmqContext [
	^self new socketPointer: socketPointer inContext: aZmqContext.
]

{ #category : #'as yet unclassified' }
ZmqSocket class >> socketType [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> addAssociation: aZmqSocketAssociation [
	monitor
		critical: [ 
			aZmqSocketAssociation associateSocket: self.
			associations add: aZmqSocketAssociation ]
]

{ #category : #'as yet unclassified' }
ZmqSocket >> bind: aByteString [
	self addAssociation: (ZmqSocketBind toTarget: aByteString).
]

{ #category : #actions }
ZmqSocket >> close [
	self logDebug:'Socket close called'.
	context removeSocket: self.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> connect: aByteString [
	self addAssociation: (ZmqSocketConnection toTarget: aByteString).
]

{ #category : #'as yet unclassified' }
ZmqSocket >> context [
	^ context
]

{ #category : #accessing }
ZmqSocket >> context: aZmqContext [
	context := aZmqContext
]

{ #category : #queries }
ZmqSocket >> dataAvailable [
	self logDebug: 'There is data available.'.
	resultHandler ifNil:[self logDebug: 'Data available, but no handler'] ifNotNil:[self receiveIfAvailable:[:data| resultHandler cull: data] ].
]

{ #category : #finalization }
ZmqSocket >> finalize [ 
	ZmqLog logDebug: 'Closing socket'.
	self close.
	ZmqLog logDebug: 'Closed socket'.
	super finalize.
]

{ #category : #accessing }
ZmqSocket >> getOption: option [ 
	|opt|
	monitor 
		critical: [ opt:= self zmqApi getSocketOption: option forSocket: self socketPointer].
	^ opt
]

{ #category : #initialization }
ZmqSocket >> initialize [ 
	super initialize.
	associations := OrderedCollection new.
	parked := false.
	monitor := Monitor new.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> logDebug: aString [
	ZmqLog logDebug: self asString,': ', aString.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> logError: aString [
	ZmqLog logError: self asString,': ', aString.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> needsPoller [ 
	^false
]

{ #category : #'as yet unclassified' }
ZmqSocket >> newSocketPointer [
	^ZmqApi apiZmqSocketInContext:  context contextPointer socketType: self socketType.

]

{ #category : #'system startup' }
ZmqSocket >> parkForSnapshot [
	monitor
		critical: [ 
			parked := true.
			self privateClose.
			]
]

{ #category : #'as yet unclassified' }
ZmqSocket >> printOn: aStream [
	aStream nextPutAll: self socketTypeName.
	aStream nextPut:$(.
	aStream nextPutAll: (',' join: associations).
	aStream nextPut:$).
]

{ #category : #'as yet unclassified' }
ZmqSocket >> privateClose [
	monitor
		critical: [ 
			socketPointer
				ifNotNil: [ 
					ZmqApi closeSocket: socketPointer.
					socketPointer := nil.] ]
]

{ #category : #'as yet unclassified' }
ZmqSocket >> receive [
	monitor 
		critical: [ 
			| messagePointer msg |
			messagePointer := self context zmqApi newMessagePointer.
			self context zmqApi initializeMessage: messagePointer.
			self context zmqApi receiveFromSocket: self socketPointer message: messagePointer.
			msg := self context zmqApi messageContent: messagePointer.
			self context zmqApi closeMessage: messagePointer.
			^ msg ]
]

{ #category : #'as yet unclassified' }
ZmqSocket >> receiveIfAvailable [
	monitor
		critical: [ 
			| read messagePointer msg |
			messagePointer := self context zmqApi newMessagePointer.
			self context zmqApi initializeMessage: messagePointer.
			read := self context zmqApi
				receiveFromSocket: self socketPointer
				message: messagePointer
				withFlags: ZmqApiConstants zmqNoBlock.
			read < 0
				ifFalse: [ 
					msg := self context zmqApi messageContent: messagePointer.
					self context zmqApi closeMessage: messagePointer ].
			^ msg ]
]

{ #category : #queries }
ZmqSocket >> receiveIfAvailable: anOneArgumentBlock [
	| data |
	data := self receiveIfAvailable.
	^ data ifNotNil: anOneArgumentBlock
]

{ #category : #'system startup' }
ZmqSocket >> reinitialize [
	monitor
		critical: [ 
			socketPointer := self newSocketPointer.
			parked := false.
			associations do: [ :association | association associateSocket: self ].			
			monitor signalAll ]
]

{ #category : #instructions }
ZmqSocket >> send: aByteArray [
	^ self send: aByteArray flags:0
]

{ #category : #'as yet unclassified' }
ZmqSocket >> send: aByteArray flags: aZmqFlags [
	monitor
		critical: [ 
			| messagePointer |
			self waitForUnpark.
			messagePointer := self context zmqApi messageFromByteArray: aByteArray.
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqSendToSocket: self socketPointer message: messagePointer withFlags: aZmqFlags]. 
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqMsgClose: messagePointer ]].
			self logDebug: 'Sent ' , aByteArray asString 
]

{ #category : #accessing }
ZmqSocket >> setOption: option to:aValue [
	|opt|
	monitor 
		critical: [ opt:= self zmqApi setSocketOption: option forSocket: self socketPointer to:aValue].
	
]

{ #category : #'as yet unclassified' }
ZmqSocket >> socketPointer [
	monitor
		critical: [ 
			self waitForUnpark.
			^ socketPointer ifNil: [ socketPointer := self newSocketPointer ] ]
]

{ #category : #'as yet unclassified' }
ZmqSocket >> socketPointer: aZmqApiSocket inContext: aZmqContext [
	socketPointer := aZmqApiSocket.
	context := aZmqContext.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> socketType [
	^self class socketType.
]

{ #category : #'as yet unclassified' }
ZmqSocket >> socketTypeName [
	self subclassResponsibility
]

{ #category : #waiting }
ZmqSocket >> wait [
	|more|
	more := 1.
	[more = 0] whileFalse:[
						more := self getOption: ZmqApiConstants zmqRcvMore.
						Processor yield ].

		
]

{ #category : #'as yet unclassified' }
ZmqSocket >> waitForUnpark [
	[ parked ] whileTrue: [ monitor wait ].
]

{ #category : #'as yet unclassified' }
ZmqSocket >> waitTilReceive [
	|msg|
	msg := nil.
	[ msg notNil and:[msg size > 0] ] whileFalse:[ 
							self receiveIfAvailable: [ :messageData|  
							messageData size > 0 
							ifTrue:[msg := messageData]
							ifFalse:[							
									Processor yield.
									(Delay forMilliseconds: 500) wait].
							]].
	^ msg
		
]

{ #category : #'as yet unclassified' }
ZmqSocket >> withResultDo: anOneArgumentBlock [
	resultHandler := anOneArgumentBlock.
	resultHandler ifNil: [ self context removeFromPoller: self ] ifNotNil: [ self context addToPoller: self ].

	
]

{ #category : #'as yet unclassified' }
ZmqSocket >> zmqApi [
	^ self context zmqApi.
]
