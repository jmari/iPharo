Class {
	#name : #IPMsgHandler,
	#superclass : #Object,
	#instVars : [
		'messageListeners'
	],
	#classVars : [
		'EventQueue'
	],
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'event handling - private' }
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

{ #category : #'event handling' }
IPMsgHandler >> onMessage: msgType do: oneParameterBlock [
	(self handlers includes: msgType) ifFalse:[ IPNonExistentHandler signal:'This object can not handle a message type:', msgType asString].  
	messageListeners add: (msgType->oneParameterBlock)
]

{ #category : #'event handling' }
IPMsgHandler >> removeListenerFor: msgType [
	(self handlers includes: msgType) ifFalse:[ IPNonExistentHandler signal:'This object can not handle a message type:', msgType asString].  
	messageListeners removeAllSuchThat:[:association|  association key = msgType ]
]
