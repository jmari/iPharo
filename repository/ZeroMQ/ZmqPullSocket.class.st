Class {
	#name : #ZmqPullSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqPullSocket class >> socketType [
	^ZmqApiConstants zmqPull.
]

{ #category : #'as yet unclassified' }
ZmqPullSocket >> needsPoller [
	 ^true
]

{ #category : #'as yet unclassified' }
ZmqPullSocket >> socketTypeName [
	^'PULL'
]
