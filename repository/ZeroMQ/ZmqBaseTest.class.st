Class {
	#name : #ZmqBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'createdSockets',
		'context'
	],
	#category : 'ZeroMQ-Tests'
}

{ #category : #convenience }
ZmqBaseTest >> closeSockets [
	createdSockets do:[:zmqSocket | zmqSocket close].
]

{ #category : #convenience }
ZmqBaseTest >> newPairSocket [
	^createdSockets add: ZmqPairSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newPublisherSocket [
	^createdSockets add: ZmqPublisherSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newPullSocket [
	^createdSockets add: ZmqPullSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newPushSocket [
	^createdSockets add: ZmqPushSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newRepSocket [
	^createdSockets add: ZmqResponseSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newReqSocket [
	^createdSockets add: ZmqRequestSocket new.
]

{ #category : #convenience }
ZmqBaseTest >> newSubscriberSocket [
	^createdSockets add: ZmqSubscriberSocket new.
]

{ #category : #running }
ZmqBaseTest >> setUp [

	context := ZmqContext current.
	createdSockets := OrderedCollection new.
]

{ #category : #running }
ZmqBaseTest >> tearDown [ 
	self closeSockets.
	context terminate.
]
