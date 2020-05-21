Class {
	#name : #ZmqResponseSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqResponseSocket class >> socketType [
	^ZmqApiConstants zmqRep.
]

{ #category : #'as yet unclassified' }
ZmqResponseSocket >> needsPoller [ 
	  ^ true
]

{ #category : #'as yet unclassified' }
ZmqResponseSocket >> socketTypeName [
	^'RES'
]
