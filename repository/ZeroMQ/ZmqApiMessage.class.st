Class {
	#name : #ZmqApiMessage,
	#superclass : #FFIExternalStructure,
	#category : #'ZeroMQ-Api'
}

{ #category : #'field definition' }
ZmqApiMessage class >> byteSize [
	^ FFIArchitecture forCurrentArchitecture longTypeSize*8
]
