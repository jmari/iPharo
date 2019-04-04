Class {
	#name : #ZmqPoller,
	#superclass : #ZmqResource,
	#instVars : [
		'pollItemStructure',
		'positionToSocketLookup',
		'socketToPositionLookup',
		'pollItemExternalAddress'
	],
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqPoller >> finalize [
	pollItemExternalAddress ifNotNil:[pollItemExternalAddress free].
	super finalize.
]

{ #category : #'as yet unclassified' }
ZmqPoller >> initialize [ 
	super initialize.
	self initializeLookups.
	self context register: self.

]

{ #category : #'as yet unclassified' }
ZmqPoller >> initializeLookups [
	positionToSocketLookup := positionToSocketLookup ifNotNil: [ :x | x removeAll ] ifNil: [ Dictionary new ].
	socketToPositionLookup := socketToPositionLookup ifNotNil: [ :x | x removeAll ] ifNil: [ IdentityDictionary new ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> poll [
	^self pollNonBlocking.
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollEventsAndSocketsDo: aBlockClosure [
	^ self pollFor: 0 milliSecond asDelay withEventsAndSocketsDo: aBlockClosure.
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollFor: aDuration [ 
	^ self poll.
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollFor: aDuration withEventsAndSocketsDo: aBlockClosure [
	| events eventsLeft position |
	self
		critical: [ 
			position := 0.
			events := self pollFor: aDuration.
			eventsLeft := events.
			[ eventsLeft > 0 and: [ position <= positionToSocketLookup size ] ]
				whileTrue: [ 
					| item |
					position := position + 1.
					item := self pollItemAt: position.
					item
						ifHasEvents: [ 
							eventsLeft := eventsLeft - 1.
							aBlockClosure value: item value: (self socketAt: position) ] ] ].
	^ events
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollInSocket: aZmqSocket [
	| position newPollItemStructure item |
	self
		critical: [ 
			position := self
				positionOfSocket: aZmqSocket
				ifAbsent: [ socketToPositionLookup at: aZmqSocket put: socketToPositionLookup size + 1 ].
			positionToSocketLookup at: position put: aZmqSocket.
			newPollItemStructure := ExternalAddress allocate: ZmqApiPollItem byteSize * positionToSocketLookup size.
			pollItemExternalAddress
				ifNotNil: [ 
					newPollItemStructure
						structAt: 1
						put: pollItemExternalAddress
						length: ZmqApiPollItem byteSize * (positionToSocketLookup size - 1).
					pollItemExternalAddress free ].
			pollItemExternalAddress := newPollItemStructure.
			item := self pollItemAt: position.
			item zmqSocket: aZmqSocket socketPointer.
			item events: ZmqApiConstants zmqPollIn.
			pollItemStructure := FFIExternalStructure fromHandle: pollItemExternalAddress ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollItemAt: anInteger [
	" Creates struct for poll item at given position. Positions start from 1."

	^ ZmqApiPollItem fromHandle: pollItemExternalAddress + ((anInteger - 1) * ZmqApiPollItem byteSize).
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollNonBlocking [
	| events |
	self
		critical: [ 
			events := self context zmqApi
				executeApiCall: [ self context zmqApi apiZmqPollSockets: pollItemStructure ofLenght: positionToSocketLookup size withTimeout: 0 ].
			events < 0
				ifTrue: [ self logError: 'Poller encountered error: ' , self zmqApi lastZmqError ].		
			^ events ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollSocket: aZmqSocket eventMask: events [
	| position newPollItemStructure item |
	self
		critical: [ 
			position := self
				positionOfSocket: aZmqSocket
				ifAbsent: [ socketToPositionLookup at: aZmqSocket put: socketToPositionLookup size + 1 ].
			positionToSocketLookup at: position put: aZmqSocket.
			newPollItemStructure := ExternalAddress allocate: ZmqApiPollItem byteSize * positionToSocketLookup size.
			pollItemExternalAddress
				ifNotNil: [ 
					newPollItemStructure
						structAt: 1
						put: pollItemExternalAddress
						length: ZmqApiPollItem byteSize * (positionToSocketLookup size - 1).
					pollItemExternalAddress free ].
			pollItemExternalAddress := newPollItemStructure.
			item := self pollItemAt: position.
			item zmqSocket: aZmqSocket socketPointer.
			item events: events.
			item filedescriptor: 0.
			pollItemStructure := FFIExternalStructure fromHandle: pollItemExternalAddress.
			^ position ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> pollSocket: aZmqSocket forEvents: aZmqEventFilter [
	self critical: [ ^ self pollSocket: aZmqSocket eventMask: aZmqEventFilter eventMask ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> positionOfSocket: aZmqSocket [
	^ self positionOfSocket: aZmqSocket ifAbsent: [ Error signal: 'Unkown socket' ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> positionOfSocket: aZmqSocket ifAbsent: aBlock [
	self critical: [ ^ socketToPositionLookup at: aZmqSocket ifAbsent: aBlock ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> rebuildPollItemStructure [
	| item |
	self logDebug:'Rebuilding poll item structure for ', socketToPositionLookup size asString, ' sockets.'.
	pollItemExternalAddress
		ifNotNil: [ 
			[ pollItemExternalAddress free ]
				on: PrimitiveFailed
				do: [ 
					"Address was faulty because of process just started"
					 ] ].
	pollItemExternalAddress := ExternalAddress allocate: ZmqApiPollItem byteSize * positionToSocketLookup size.
	positionToSocketLookup
		keysAndValuesDo: [ :position :socket | 
			item := self pollItemAt: position.
			item zmqSocket: socket socketPointer.
			item events: ZmqApiConstants zmqPollIn.
			pollItemStructure := FFIExternalStructure fromHandle: pollItemExternalAddress ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> reinitialize [
	self rebuildPollItemStructure.
	super reinitialize.
]

{ #category : #'as yet unclassified' }
ZmqPoller >> removeSocket: aZmqSocket [
	| sockets |
	self
		critical: [ 
			| oldSockets |
			oldSockets := socketToPositionLookup keys.
			sockets := oldSockets copyWithout: aZmqSocket.
			self logDebug: 'Before removal ', oldSockets size asString, ' after removal ', sockets size asString,'.'.
			self initializeLookups.
			sockets asArray
				keysAndValuesDo: [ :i :v | 
					socketToPositionLookup at: v put: i.
					positionToSocketLookup at: i put: v.
					 ].
				self rebuildPollItemStructure.
				 ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> size [
	self critical: [ ^ positionToSocketLookup size ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> socketAt: anInteger [
	self critical: [ ^ self socketAt: anInteger ifAbsent: [ Error signal: 'Unkown socket' ] ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> socketAt: anInteger ifAbsent: aBlock [
	self critical: [ ^ positionToSocketLookup at: anInteger ifAbsent: aBlock ]
]

{ #category : #'as yet unclassified' }
ZmqPoller >> zmqApi [
	^self context zmqApi.
]
