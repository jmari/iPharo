Class {
	#name : #ZmqApiStructForInt,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_VALUE'
	],
	#category : 'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiStructForInt class >> fieldsDesc [
^#(int value)
	
]

{ #category : #printing }
ZmqApiStructForInt >> printOn: aStream [
	aStream nextPutAll: self value asString.
]

{ #category : #'accessing structure variables' }
ZmqApiStructForInt >> value [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_VALUE
]

{ #category : #'accessing structure variables' }
ZmqApiStructForInt >> value: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_VALUE put: anObject
]
