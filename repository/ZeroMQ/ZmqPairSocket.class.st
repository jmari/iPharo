Class {
	#name : #ZmqPairSocket,
	#superclass : #ZmqSocket,
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqPairSocket class >> socketType [
	^ZmqApiConstants zmqPair.
]

{ #category : #'as yet unclassified' }
ZmqPairSocket >> socketTypeName [
	^'PAIR'
]
