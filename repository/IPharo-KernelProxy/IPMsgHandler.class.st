Class {
	#name : #IPMsgHandler,
	#superclass : #Object,
	#instVars : [
		'messageListeners'
	],
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #convenience }
IPMsgHandler >> evaluateListenersFor: anIPMessage [
	(messageListeners select:[ :pair | pair key = anIPMessage msgType ]) do:[:pair |
		pair value value: anIPMessage ]
]

{ #category : #accessing }
IPMsgHandler >> handlers [ 
	^ (Pragma allNamed: #ipharo:  in: self class) collect:[: pragma |pragma arguments first ]
]

{ #category : #initialization }
IPMsgHandler >> initialize [ 
	super initialize.
	messageListeners := OrderedCollection new.
]

{ #category : #convenience }
IPMsgHandler >> on: msgType do: oneParameterBlock [
	(self handlers includes: msgType) ifFalse:[ Error signal:'This object can not handle a message type:', msgType asString].  
	messageListeners add: (msgType->oneParameterBlock)
]
