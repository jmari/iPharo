Class {
	#name : #ZmqPollIn,
	#superclass : #ZmqEventFilter,
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqPollIn class >> eventMask [
	^ZmqApiConstants zmqPollIn.
]
