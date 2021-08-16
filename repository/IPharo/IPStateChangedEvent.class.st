Class {
	#name : #IPStateChangedEvent,
	#superclass : #Object,
	#instVars : [
		'oldValue',
		'newValue',
		'sender'
	],
	#category : #'IPharo-Widgets'
}

{ #category : #accessing }
IPStateChangedEvent >> newValue [
	^ newValue
]

{ #category : #accessing }
IPStateChangedEvent >> newValue: anObject [
	newValue := anObject
]

{ #category : #accessing }
IPStateChangedEvent >> oldValue [
	^ oldValue
]

{ #category : #accessing }
IPStateChangedEvent >> oldValue: anObject [
	oldValue := anObject
]

{ #category : #accessing }
IPStateChangedEvent >> sender [
	^ sender
]

{ #category : #accessing }
IPStateChangedEvent >> sender: anObject [
	sender := anObject
]
