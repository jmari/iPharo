Class {
	#name : #IPStreamMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-IOPub'
}

{ #category : #initialization }
IPStreamMsg >> initialize [
	super initialize.
	self msgType: #stream.
]

{ #category : #accessing }
IPStreamMsg >> name [
	^ self content name
]

{ #category : #accessing }
IPStreamMsg >> name: aString [
	self content name:aString
	
]

{ #category : #accessing }
IPStreamMsg >> text [
	^ self content text
]

{ #category : #accessing }
IPStreamMsg >> text: aString [
	self content text:aString
]
