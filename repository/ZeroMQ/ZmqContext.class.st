Class {
	#name : #ZmqContext,
	#superclass : #Object,
	#instVars : [
		'api',
		'parked',
		'contextPointer',
		'resources',
		'monitor',
		'globalPoller'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'ZeroMQ'
}

{ #category : #'instance creation' }
ZmqContext class >> current [
	^ self new.
]

{ #category : #'class initialization' }
ZmqContext class >> initialize [

	SessionManager default registerUserClassNamed: self name  atPriority: 101.

]

{ #category : #'instance creation' }
ZmqContext class >> new [
	"There is only on thread in Squeak VM so there can only be one context."

	^ instance
		ifNil: [ instance := super new ]
		ifNotNil: [ 
			instance isTerminated
				ifTrue: [ 
					instance := nil.
					self new ]
				ifFalse: [ instance ] ]
]

{ #category : #'system startup' }
ZmqContext class >> shutDown [
	instance ifNotNil: [instance parkForSnapshot].
	Smalltalk garbageCollect.
	
]

{ #category : #'system startup' }
ZmqContext class >> startUp [
	instance
		ifNotNil: [instance reinitialize]
]

{ #category : #'instance creation' }
ZmqContext class >> terminate [
	instance ifNotNil: [ instance terminate ]
]

{ #category : #'as yet unclassified' }
ZmqContext >> addToPoller:aSocket [
	self globalPoller pollInSocket: aSocket.
]

{ #category : #accessing }
ZmqContext >> contextPointer [
	^contextPointer ifNil: [ contextPointer := self zmqApi newContextPointer ]
]

{ #category : #finalization }
ZmqContext >> finalize [ 
	self terminate.
	super finalize.
]

{ #category : #'as yet unclassified' }
ZmqContext >> globalPoller [
	^ globalPoller ifNil:[	globalPoller := ZmqGlobalPoller onContext:self ]
]

{ #category : #initialization }
ZmqContext >> initialize [ 
	super initialize.
	api := ZmqApi forCurrentVersion.
	resources := WeakSet new.
	parked := false.
	monitor := Monitor new.

	
]

{ #category : #testing }
ZmqContext >> isTerminated [
	^false.
]

{ #category : #private }
ZmqContext >> newSocket: aSocketClass [
	| socket |
	socket := aSocketClass context: self.
	self register: socket.
	^ socket
]

{ #category : #'system startup' }
ZmqContext >> parkForSnapshot [
	monitor
		critical: [ 
			globalPoller ifNotNil: [ globalPoller parkForSnapshot ].
			resources do: [ :resource | resource parkForSnapshot ].
			self privateTerminate.
			parked := true ]
]

{ #category : #private }
ZmqContext >> privateTerminate [
	contextPointer
		ifNotNil: [ 
			self zmqApi terminateContextPointer: contextPointer.
			contextPointer := nil ]
]

{ #category : #private }
ZmqContext >> register: anObject [
	resources add: anObject
]

{ #category : #'system startup' }
ZmqContext >> reinitialize [
	monitor
		critical: [ 
			parked := false.
			resources do: [ :resource | resource reinitialize ].
			globalPoller ifNotNil: [globalPoller reinitialize].
			monitor signalAll.
			
			]
]

{ #category : #'as yet unclassified' }
ZmqContext >> removeFromPoller: aSocket [
	globalPoller ifNotNil: [ globalPoller removeSocket: aSocket ]
]

{ #category : #private }
ZmqContext >> removeSocket: aZmqSocket [
	resources remove: aZmqSocket.
	self removeFromPoller: aZmqSocket.
	aZmqSocket privateClose
]

{ #category : #controlling }
ZmqContext >> terminate [
	globalPoller ifNotNil:[ globalPoller stopPolling ].
	resources do: [ :zmqSocket | zmqSocket privateClose ].
	resources removeAll.
	self privateTerminate.
	self become: ZmqTerminatedContext new.
]

{ #category : #'system startup' }
ZmqContext >> zmqApi [ 
	^ api
]
