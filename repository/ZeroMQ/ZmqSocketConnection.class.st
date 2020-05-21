Class {
	#name : #ZmqSocketConnection,
	#superclass : #ZmqSocketAssociation,
	#category : #'ZeroMQ-Core'
}

{ #category : #operations }
ZmqSocketConnection >> associateSocket:  aZmqSocket [
	aZmqSocket zmqApi connectSocket: aZmqSocket socketPointer to: target.
]

{ #category : #'as yet unclassified' }
ZmqSocketConnection >> associationTypeName [ 
	^'connetion'
]
