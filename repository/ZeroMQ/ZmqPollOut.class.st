Class {
	#name : #ZmqPollOut,
	#superclass : #ZmqEventFilter,
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqPollOut class >> eventMask [
	^ZmqApiConstants zmqPollOut.
]
