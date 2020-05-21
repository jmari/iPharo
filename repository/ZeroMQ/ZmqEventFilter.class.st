Class {
	#name : #ZmqEventFilter,
	#superclass : #Object,
	#instVars : [
		'eventMask'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqEventFilter class >> , aZmqEventFilter [
	^ZmqEventFilter  new eventMask: (self eventMask bitOr: aZmqEventFilter eventMask).
]

{ #category : #'as yet unclassified' }
ZmqEventFilter class >> eventMask [
	^0.
]

{ #category : #'as yet unclassified' }
ZmqEventFilter >> eventMask [
	^eventMask.
]

{ #category : #'as yet unclassified' }
ZmqEventFilter >> eventMask: anInteger [
	eventMask:=anInteger.
]
