"
I store the basic info about a handler for a jupyter message implementation inside a method
"
Class {
	#name : #IPHandler,
	#superclass : #Object,
	#instVars : [
		'methodName',
		'receiver',
		'messageSelector'
	],
	#category : #'IPharo-Core'
}

{ #category : #'as yet unclassified' }
IPHandler >> executeWithArguments: anArrayOrDictionary [
	^ self
		send: self messageSelector
		to: self receiver
		with: anArrayOrDictionary
]

{ #category : #accessing }
IPHandler >> messageSelector [

	^ messageSelector
]

{ #category : #accessing }
IPHandler >> messageSelector: anObject [

	messageSelector := anObject
]

{ #category : #accessing }
IPHandler >> methodName [

	^ methodName
]

{ #category : #accessing }
IPHandler >> methodName: anObject [

	methodName := anObject
]

{ #category : #'as yet unclassified' }
IPHandler >> parametersCount [
	"Returns the number of parameters expected by the handler."
	^ self parametersNames size
]

{ #category : #'as yet unclassified' }
IPHandler >> parametersNames [
	^ (self receiver class >> self messageSelector) argumentNames
]

{ #category : #accessing }
IPHandler >> receiver [

	^ receiver
]

{ #category : #accessing }
IPHandler >> receiver: anObject [

	receiver := anObject
]

{ #category : #'as yet unclassified' }
IPHandler >> send: aSelector to: aReceiver with: arguments [
	^ aReceiver perform: aSelector with: arguments
]
