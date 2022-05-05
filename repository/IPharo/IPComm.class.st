Class {
	#name : #IPComm,
	#superclass : #Object,
	#instVars : [
		'uuid',
		'targetName',
		'commMsgListener',
		'session',
		'data'
	],
	#category : #'IPharo-Comm'
}

{ #category : #'instance creation' }
IPComm class >> new: anUUID [
	|instance|
	instance := self new.
	instance uuid: anUUID.
	^ instance 
	
]

{ #category : #'instance creation' }
IPComm class >> new: anUUID onSession: anIPSession [
	|instance|
	instance := self new: anUUID.
	instance session: anIPSession.
	anIPSession commManager registerComm: instance.
	^ instance
	
]

{ #category : #'instance creation' }
IPComm class >> onSession: anIPSession [
	|instance|
	instance := self new.
	instance session: anIPSession.
	anIPSession commManager registerComm: instance.
	^ instance
	
]

{ #category : #versions }
IPComm class >> version [
	^ '2.0.0'
]

{ #category : #'comm handlers' }
IPComm >> addCommListener: aCommListener [
	self commListeners add:aCommListener
]

{ #category : #'instance creation' }
IPComm >> close [
	self close:nil
]

{ #category : #'instance creation' }
IPComm >> close:data [
	self publish: ( self session commCloseMessage  new 
																	data: data;
																	commID: self uuid;
																	targetName: self targetName;
																	yourself )
]

{ #category : #accessing }
IPComm >> commListeners [
	^ commMsgListener ifNil:[ commMsgListener:= OrderedCollection new]
]

{ #category : #accessing }
IPComm >> commManager [

	^ self session commManager 
]

{ #category : #accessing }
IPComm >> data [ 
	"data stores the last data received in this channel for testing purpose
	because data should be hadled by the classes listening to this comm channel inside
	#onDataEvent:"
	^ data ifNil:[ data := SCJsonObject new  ]
]

{ #category : #accessing }
IPComm >> data: aJsonObject [
	data := aJsonObject 
]

{ #category : #'instance creation' }
IPComm >> open [

	"AKI HAY QUE envíar en open el contenido del modelo del widget"
	self open: nil
]

{ #category : #'instance creation' }
IPComm >> open: someData [

	self publish: (self session commOpenMessage 
															data: someData;
															commID: self uuid;
															targetName: self targetName;
															yourself)
]

{ #category : #'comm handlers' }
IPComm >> publish: aResult [
	self publisher publish: aResult
]

{ #category : #accessing }
IPComm >> publisher [

	^ self session publisher
]

{ #category : #'comm handlers' }
IPComm >> removeCommMsgListeners [ 
	self commListeners removeAll
]

{ #category : #'comm handlers' }
IPComm >> send: data [
	self publish: (self session commMsgMessage 
														commID: self uuid;
														data:data;
														targetName: self targetName;
														yourself)
]

{ #category : #accessing }
IPComm >> session [

	^ session
]

{ #category : #accessing }
IPComm >> session: anIPSession [

	session := anIPSession
	
]

{ #category : #accessing }
IPComm >> targetName [
	^ targetName 
]

{ #category : #accessing }
IPComm >> targetName: aString [
	targetName := aString
]

{ #category : #'instance creation' }
IPComm >> update: state [

	self publish: (self session commUpdateMessage 
															state: state;
															commID: self uuid;
															yourself)
]

{ #category : #accessing }
IPComm >> uuid [
	^ uuid ifNil:[ uuid:= UUID new hex asString asUppercase].
]

{ #category : #accessing }
IPComm >> uuid: anObject [
	uuid := anObject
]
