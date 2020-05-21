Class {
	#name : #ZmqApiContext,
	#superclass : #FFIExternalStructure,
	#category : #'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiContext class >> fieldsDesc [
	^#()
]

{ #category : #controlling }
ZmqApiContext >> terminate [
	ZmqApi apiZmqTerm: self.
]
