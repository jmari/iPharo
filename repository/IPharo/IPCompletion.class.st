Class {
	#name : #IPCompletion,
	#superclass : #Object,
	#instVars : [
		'completionContext',
		'source',
		'position'
	],
	#category : #'IPharo-Completion'
}

{ #category : #accessing }
IPCompletion >> completionContext [
	^ completionContext
]

{ #category : #accessing }
IPCompletion >> completionContext: anObject [
	completionContext := anObject
]

{ #category : #accessing }
IPCompletion >> entries [
	completionContext := CompletionContext
		engine: IPCompletionEngine new
		class: nil
		source: self source
		position: self position.
	^ { (self completionContext entries
		collectWithIndex: [ :entry :index |
			entry contents
				"documentation: entry description description;"
				 ]) asArray.
			self position - self completionContext completionToken size.
			self position }
			
]

{ #category : #private }
IPCompletion >> getCompletionListFrom: aMessage [
	
	self source:(aMessage content at:#code). 
	self position: (aMessage content at:#cursor_pos).
	self completionContext:  (IPSession session: aMessage header session).
	^self entries
]

{ #category : #accessing }
IPCompletion >> position [
	^ position
]

{ #category : #accessing }
IPCompletion >> position: anInteger [
	^ position := anInteger

]

{ #category : #accessing }
IPCompletion >> source [
	^ source
]

{ #category : #accessing }
IPCompletion >> source: aSource [
	source := aSource
]
