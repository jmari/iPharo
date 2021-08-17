Class {
	#name : #IPInputRequestMsg,
	#superclass : #IPMsg,
	#instVars : [
		'prompt'
	],
	#category : #'IPharo-Messages-StdIn'
}

{ #category : #initialization }
IPInputRequestMsg >> initialize [
	super initialize.
	self msgType: #input_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#prompt-> ''.
						#password-> false} asSCJsonObject . 
]

{ #category : #'as yet unclassified' }
IPInputRequestMsg >> isPassword [	
	self content password:true
]

{ #category : #'as yet unclassified' }
IPInputRequestMsg >> prompt [ 	
	^ self content prompt
]

{ #category : #'as yet unclassified' }
IPInputRequestMsg >> prompt: aPromptString [ 	
	self content prompt: aPromptString
]
