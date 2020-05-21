Class {
	#name : #ZmqApiPollItem,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_EVENTS',
		'OFFSET_FILEDESCRIPTOR',
		'OFFSET_REVENTS',
		'OFFSET_ZMQSOCKET'
	],
	#category : #'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiPollItem class >> fieldsDesc [
	^#(
			ZmqApiSocket* zmqSocket;
			int filedescriptor;
			short  events;
			short  revents;
		)
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> events [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_EVENTS
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> events: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_EVENTS put: anObject
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> filedescriptor [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_FILEDESCRIPTOR
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> filedescriptor: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_FILEDESCRIPTOR put: anObject
]

{ #category : #testing }
ZmqApiPollItem >> hasEventMask: anInteger [
	^(self revents bitAnd: anInteger) = anInteger
]

{ #category : #testing }
ZmqApiPollItem >> ifEvent: bitMask occuredDo:  aBlock [
	^(self hasEventMask: bitMask) ifTrue: aBlock.
]

{ #category : #testing }
ZmqApiPollItem >> ifHasEvents:aBlock [
	^self revents > 0 ifTrue: aBlock.
]

{ #category : #testing }
ZmqApiPollItem >> ifReadEvent:aBlock [
	^self ifEvent: ZmqApiConstants zmqPollIn occuredDo: aBlock.
]

{ #category : #'as yet unclassified' }
ZmqApiPollItem >> isPollIn [
	^ self hasEventMask: ZmqPollIn eventMask.
]

{ #category : #'as yet unclassified' }
ZmqApiPollItem >> isPollOut [
	^ self hasEventMask: ZmqPollOut eventMask.
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> revents [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_REVENTS
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> revents: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_REVENTS put: anObject
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> zmqSocket [
	"This method was automatically generated"
	^ZmqApiSocket fromHandle: (handle pointerAt: OFFSET_ZMQSOCKET)
]

{ #category : #'accessing structure variables' }
ZmqApiPollItem >> zmqSocket: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ZMQSOCKET put: anObject getHandle.
]
