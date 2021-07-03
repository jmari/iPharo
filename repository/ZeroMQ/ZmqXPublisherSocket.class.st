Class {
	#name : #ZmqXPublisherSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqXPublisherSocket class >> socketType [
	^ZmqApiConstants zmqXPub.
]

{ #category : #'as yet unclassified' }
ZmqXPublisherSocket >> socketTypeName [
	^'XPUB'
]
