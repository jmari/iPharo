Class {
	#name : #IPWireMessage,
	#superclass : #Object,
	#instVars : [
		'wireMessage',
		'currentProperty'
	],
	#category : #'IPharo-Core'
}

{ #category : #'instance creation' }
IPWireMessage class >> newFromMessage: anIPMessage [
	|instance serializer|
	serializer := SCSerializer new.
	instance := self new.
	"be sure message type is the correct msgType
	uuid is set in the IPMessageProcessor #execute: method"
	instance push: anIPMessage uuid asByteArray.
	instance push: 0.
	instance push: (serializer serialize: anIPMessage header) asByteArray.
	"parent_header must be exactly the same header, this could not be serialized/materialized"
	instance push: anIPMessage parentHeader.
	instance push: (serializer serialize: anIPMessage metadata) asByteArray.
	instance push: (serializer serialize: anIPMessage content) utf8Encoded.
	instance hmac: instance calculateHMAC hex asByteArray.
	^instance
]

{ #category : #'as yet unclassified' }
IPWireMessage >> calculateHMAC [
	^ (HMAC on: SHA256)
			key: IPharoKernel instance sharedKey asByteArray ;
			digestMessage:
						self header,
						self parentHeader,
						self metadata,
						self content  
]

{ #category : #accessing }
IPWireMessage >> content [
	^ wireMessage at:6 
		
]

{ #category : #accessing }
IPWireMessage >> extra [
	^ wireMessage at:7 
		
]

{ #category : #accessing }
IPWireMessage >> header [
	^ wireMessage at:3 
		
]

{ #category : #accessing }
IPWireMessage >> hmac [
	^ wireMessage at:2
]

{ #category : #accessing }
IPWireMessage >> hmac: hmac [
	wireMessage at:2 put:hmac
]

{ #category : #converting }
IPWireMessage >> hmacIsValid [
^	self hmac asString = self calculateHMAC hex 
	
]

{ #category : #initialization }
IPWireMessage >> initialize [
	super initialize.
	wireMessage := Array new:7.
	wireMessage from: 1 to: 7 put: ByteArray new.
	currentProperty := 1
]

{ #category : #testing }
IPWireMessage >> isEmpty [
	^ currentProperty= 1
]

{ #category : #testing }
IPWireMessage >> isFull [
	^ currentProperty >= wireMessage size
]

{ #category : #accessing }
IPWireMessage >> metadata [
	^ wireMessage at:5 
		
]

{ #category : #converting }
IPWireMessage >> parentHeader [
	^ wireMessage at:4 
		
]

{ #category : #initialization }
IPWireMessage >> push: aProperty [
	currentProperty <= wireMessage size ifTrue:[wireMessage at:currentProperty put:aProperty].
	currentProperty := currentProperty + 1
	
]

{ #category : #accessing }
IPWireMessage >> uuid [
	^ wireMessage at:1 ifAbsent:[ByteArray new]
]

{ #category : #accessing }
IPWireMessage >> uuid: aZmqUUID [
	wireMessage at:1 put: aZmqUUID
]
