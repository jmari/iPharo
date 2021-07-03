Class {
	#name : #ZmqXSubscriberSocket,
	#superclass : #ZmqSocket,
	#instVars : [
		'subscriptions'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqXSubscriberSocket class >> socketType [
	^ZmqApiConstants zmqXSub.
]

{ #category : #initialization }
ZmqXSubscriberSocket >> initialize [
	super initialize.
	subscriptions := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ZmqXSubscriberSocket >> needsPoller [ 
	^ true.
]

{ #category : #private }
ZmqXSubscriberSocket >> privateSubscribe: aByteArray [
	self context zmqApi setSocketOption: ZmqApiConstants zmqSubscribe forSocket: self socketPointer to: aByteArray.  
]

{ #category : #'system startup' }
ZmqXSubscriberSocket >> reinitialize [
	super reinitialize.
	subscriptions do:[:subscription| self privateSubscribe: subscription ].
]

{ #category : #'as yet unclassified' }
ZmqXSubscriberSocket >> socketTypeName [
	^'XSUB'
]

{ #category : #operations }
ZmqXSubscriberSocket >> subscribe: aByteArray [
	self privateSubscribe: aByteArray.		  
	subscriptions add: aByteArray.
]

{ #category : #operations }
ZmqXSubscriberSocket >> subscribeAll [
	self subscribe: ''.

]
