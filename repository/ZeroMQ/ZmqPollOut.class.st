Class {
	#name : #ZmqPollOut,
	#superclass : #ZmqEventFilter,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqPollOut class >> eventMask [
	^ZmqApiConstants zmqPollOut.
]
