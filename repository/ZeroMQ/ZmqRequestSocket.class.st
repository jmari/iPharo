Class {
	#name : #ZmqRequestSocket,
	#superclass : #ZmqSocket,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqRequestSocket class >> socketType [
	^ZmqApiConstants zmqReq.
]

{ #category : #'as yet unclassified' }
ZmqRequestSocket >> needsPoller [ 
	  ^ true
]

{ #category : #'as yet unclassified' }
ZmqRequestSocket >> socketTypeName [
	^'REQ'
]
