Class {
	#name : #ZmqPublisherSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqPublisherSocket class >> socketType [
	^ZmqApiConstants zmqPub.
]

{ #category : #'as yet unclassified' }
ZmqPublisherSocket >> socketTypeName [
	^'PUB'
]
