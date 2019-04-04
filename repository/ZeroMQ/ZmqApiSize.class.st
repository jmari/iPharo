Class {
	#name : #ZmqApiSize,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_SIZE'
	],
	#category : 'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiSize class >> fieldsDesc [
	^#(size_t size)
]

{ #category : #printing }
ZmqApiSize >> printOn: aStream [
	aStream nextPutAll: self size asString.
]

{ #category : #evaluating }
ZmqApiSize >> size [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_SIZE
]

{ #category : #accessing }
ZmqApiSize >> size: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_SIZE put: anObject
]
