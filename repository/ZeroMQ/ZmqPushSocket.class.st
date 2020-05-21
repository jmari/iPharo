Class {
	#name : #ZmqPushSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqPushSocket class >> socketType [
	^ZmqApiConstants zmqPush.
]

{ #category : #'as yet unclassified' }
ZmqPushSocket >> socketTypeName [
	^'PUSH'
]
