Class {
	#name : #ZmqSocketBind,
	#superclass : #ZmqSocketAssociation,
	#category : #'ZeroMQ-Core'
}

{ #category : #operations }
ZmqSocketBind >> associateSocket:  aZmqSocket [
	aZmqSocket zmqApi bindSocket: aZmqSocket socketPointer to: target.
]

{ #category : #'as yet unclassified' }
ZmqSocketBind >> associationTypeName [ 
	^ 'bind'
]
