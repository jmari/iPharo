Class {
	#name : #ZmqApiConstants,
	#superclass : #Object,
	#category : 'ZeroMQ-Api'
}

{ #category : #'errno codes' }
ZmqApiConstants class >> errnoEAGAIN [
	"Try again"
	^11
]

{ #category : #'errno codes' }
ZmqApiConstants class >> errnoEINTR [
	"Interrupted system call"
	 ^4.
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqAffinity [
	^4
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqDealer [
	^5
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqDontWait [
	^1
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqHwm [
	^1
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqIdentity [
	^5
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqNoBlock [ 
	^1
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqPair [
	^0
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqPollErr [
	^4
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqPollIn [
	^1
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqPollOut [
	^2
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqPub [
	^1
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqPull [
	^7
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqPush [
	^8
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqRate [
	^8
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqRcvHwm [
	^24

]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqRcvMore [
	^13
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqRep [
	^4
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqReq [
	^3
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqRouter [
	^6
]

{ #category : #'as yet unclassified' }
ZmqApiConstants class >> zmqSendMore [
	^2
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqSndHwm [
	^23

]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqSub [
	^2
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqSubscribe [
	^6
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqSwap [
	^3
]

{ #category : #'Socket options' }
ZmqApiConstants class >> zmqUnsubscribe [
	^7
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqXPub [
	^9
]

{ #category : #'Socket types' }
ZmqApiConstants class >> zmqXSub [
	^10
]
