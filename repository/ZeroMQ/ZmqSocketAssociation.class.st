Class {
	#name : #ZmqSocketAssociation,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqSocketAssociation class >> toTarget: aString [
	^self new target: aString.
]

{ #category : #operations }
ZmqSocketAssociation >> associateSocket: aZmqSocket [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ZmqSocketAssociation >> associationTypeName [ 
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ZmqSocketAssociation >> printOn: aStream [
	aStream nextPutAll: self associationTypeName.
	aStream nextPutAll: ':'.
	aStream nextPutAll: self target.
	
]

{ #category : #accessing }
ZmqSocketAssociation >> target [
	^ target
]

{ #category : #accessing }
ZmqSocketAssociation >> target: anObject [
	target := anObject
]
