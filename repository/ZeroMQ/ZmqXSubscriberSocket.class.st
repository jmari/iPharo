Class {
	#name : #ZmqXSubscriberSocket,
	#superclass : #ZmqSubscriberSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqXSubscriberSocket class >> socketType [
	^ZmqApiConstants zmqXSub.
]

{ #category : #'as yet unclassified' }
ZmqXSubscriberSocket >> socketTypeName [
	^'XSUB'
]
