Class {
	#name : #ZmqPollIn,
	#superclass : #ZmqEventFilter,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqPollIn class >> eventMask [
	^ZmqApiConstants zmqPollIn.
]
