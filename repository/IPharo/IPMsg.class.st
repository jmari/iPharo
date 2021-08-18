Class {
	#name : #IPMsg,
	#superclass : #Object,
	#instVars : [
		'header',
		'msg_id',
		'msg_type',
		'parentHeader',
		'content',
		'metadata',
		'uuid',
		'msgUUID',
		'wireMessage'
	],
	#category : #'IPharo-Core'
}

{ #category : #'instance creation' }
IPMsg class >> newFromWireMessage: aWireMessage [
	| instance materializer |
	materializer := SCMaterializer new.
	instance := self new.
	instance header: ( materializer materialize: aWireMessage header asString).	
	instance parentHeader: (materializer materialize: aWireMessage parentHeader asString).
	instance metadata: ( materializer materialize: aWireMessage metadata asString).
	instance content: ( materializer materialize: aWireMessage content asString).
	instance msgId: (instance header ifNil:[nil] ifNotNil:[instance header msg_id]).
	instance msgType: (instance header ifNil:[nil] ifNotNil:[instance header msg_type]).
	instance wireMessage: aWireMessage.
	^ instance
]

{ #category : #'instance creation' }
IPMsg class >> newReplyingToWireMessage: aWireMessage [
	| instance |
	instance := self new.
	instance replyingToWireMessage: aWireMessage.
	^ instance
]

{ #category : #accessing }
IPMsg >> content [
	^ content ifNil:[ content := SCJsonObject new ]
]

{ #category : #accessing }
IPMsg >> content: anObject [
	content := anObject
]

{ #category : #accessing }
IPMsg >> header [
	^ header ifNil:[ header := {
                'msg_id' -> self msgUUID.
                'date' -> DateAndTime now asString. 
                'msg_type' -> self msgType.
                'version' -> '5.0'.
     } asSCJsonObject ]
]

{ #category : #accessing }
IPMsg >> header: anObject [
	header := anObject
]

{ #category : #accessing }
IPMsg >> metadata [
	^ metadata ifNil:[ metadata := SCJsonObject new ]
]

{ #category : #accessing }
IPMsg >> metadata: anObject [
	metadata := anObject
]

{ #category : #accessing }
IPMsg >> msgId [
	^ msg_id ifNil:[ msg_id:= UUID new hex asString asUppercase ].
]

{ #category : #accessing }
IPMsg >> msgId: anObject [
	msg_id := anObject
]

{ #category : #accessing }
IPMsg >> msgType [
	^ msg_type
]

{ #category : #accessing }
IPMsg >> msgType: anObject [
	msg_type := anObject
]

{ #category : #accessing }
IPMsg >> msgUUID [
 	^ msgUUID ifNil:[ UUID new hex asString asUppercase ].
]

{ #category : #accessing }
IPMsg >> parentHeader [
	^ parentHeader ifNil:[ parentHeader := SCJsonObject new asByteArray ]
]

{ #category : #accessing }
IPMsg >> parentHeader: anObject [
	parentHeader := anObject
]

{ #category : #'class membership' }
IPMsg >> replyingToWireMessage: aWireMessage [

	self parentHeader: aWireMessage header.
	self uuid: aWireMessage uuid.
]

{ #category : #accessing }
IPMsg >> uuid [
 	^ uuid ifNil:[ uuid := UUID new hex asString asUppercase ].
]

{ #category : #accessing }
IPMsg >> uuid: aString [
 	uuid :=aString.
]

{ #category : #accessing }
IPMsg >> wireMessage [

	^ wireMessage
]

{ #category : #accessing }
IPMsg >> wireMessage: anObject [

	wireMessage := anObject
]
