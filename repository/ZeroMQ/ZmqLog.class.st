Class {
	#name : #ZmqLog,
	#superclass : #Object,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqLog class >> logDebug: aString [
	self logInfo: aString
]

{ #category : #'as yet unclassified' }
ZmqLog class >> logError: aString [
	self logInfo: aString
]

{ #category : #'as yet unclassified' }
ZmqLog class >> logInfo: aString [
	"self trace: DateAndTime now asString , ' - ' , aString , String cr"
]
