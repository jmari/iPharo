Class {
	#name : #ZmqApiSocket,
	#superclass : #FFIExternalStructure,
	#category : 'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiSocket class >> fieldsDesc [
	^#()
]

{ #category : #controlling }
ZmqApiSocket >> close [
	ZmqApi apiZmqClose: self.
]
