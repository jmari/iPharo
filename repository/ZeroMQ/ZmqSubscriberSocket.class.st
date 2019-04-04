Class {
	#name : #ZmqSubscriberSocket,
	#superclass : #ZmqSocket,
	#instVars : [
		'subscriptions'
	],
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqSubscriberSocket class >> socketType [
	^ZmqApiConstants zmqSub.
]

{ #category : #initialization }
ZmqSubscriberSocket >> initialize [
	super initialize.
	subscriptions := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ZmqSubscriberSocket >> needsPoller [ 
	^ true.
]

{ #category : #private }
ZmqSubscriberSocket >> privateSubscribe: aByteArray [
	self context zmqApi setSocketOption: ZmqApiConstants zmqSubscribe forSocket: self socketPointer to: aByteArray.  
]

{ #category : #'system startup' }
ZmqSubscriberSocket >> reinitialize [
	super reinitialize.
	subscriptions do:[:subscription| self privateSubscribe: subscription ].
]

{ #category : #'as yet unclassified' }
ZmqSubscriberSocket >> socketTypeName [
	^'SUB'
]

{ #category : #operations }
ZmqSubscriberSocket >> subscribe: aByteArray [
	self privateSubscribe: aByteArray.		  
	subscriptions add: aByteArray.
]

{ #category : #operations }
ZmqSubscriberSocket >> subscribeAll [
	self subscribe: ''.

]
