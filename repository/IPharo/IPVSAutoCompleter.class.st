"
very simple autocompleter....
"
Class {
	#name : #IPVSAutoCompleter,
	#superclass : #Object,
	#instVars : [
		'objectStartPos',
		'previousCodePos',
		'lastSpace',
		'cursorPos',
		'previousCode',
		'codeForOjectType',
		'messagePart',
		'objectType',
		'objectPart'
	],
	#category : #'IPharo-Completer'
}

{ #category : #'to clean later' }
IPVSAutoCompleter >> allClasses [
	^ Smalltalk globals keys collect: [ :c | c asString ]
]

{ #category : #'as yet unclassified' }
IPVSAutoCompleter >> evaluateTypeOfObjectInSession: session [  
	| result list |
	"evaluate previous lines of code"
	[session evaluate: previousCode] on:Error do:[:e| Transcript show: e asString;cr].
	"evaluate the code to guess the object class "
	[self shouldBeAClass 
		ifTrue:[list := self allClasses]
		ifFalse:[result :=session evaluate: codeForOjectType]]
	on:Error do:[:e| result := Object].

	self shouldBeAClass 
		ifTrue:[ messagePart trimBoth ='' ifTrue:[messagePart := objectPart]]
		ifFalse:[
			objectType := result.
			list :=(result allSuperclasses 
									flatCollect:[:aClass| aClass selectors]) addAll:(result selectors);yourself].
		
	^ {(list select:[:element|  (messagePart ,'*') match: element ] ) asSet asArray sort.
		(objectStartPos + lastSpace).
		cursorPos}.
]

{ #category : #private }
IPVSAutoCompleter >> getCompletionListFrom: aMessage [
	|session codeString  |
	
	codeString := (aMessage content at:#code). 
	cursorPos := (aMessage content at:#cursor_pos).
	session := (IPSession session: aMessage header session) veryDeepCopy.
	self parseObjectAndPartOfMessage: codeString.
	^ self evaluateTypeOfObjectInSession: session
	
]

{ #category : #'as yet unclassified' }
IPVSAutoCompleter >> guessObjectCode: codeForObject [
 ^ '((' , codeForObject , ') class = UndefinedObject )
	ifTrue:[Error signal:''foo'']
	ifFalse:[
			(' , codeForObject , ') class]'.
]

{ #category : #accessing }
IPVSAutoCompleter >> objectType [
	^objectType
]

{ #category : #parsing }
IPVSAutoCompleter >> parseObjectAndPartOfMessage: codeString [ 
	| balanced trail interestingCode followLoop |
	
	objectStartPos := cursorPos.	
	balanced := 0.	
	trail := String new.
	followLoop := true.
	[ objectStartPos>0 and:[(self stopChars includes: (codeString at:objectStartPos)) not and:[followLoop] ]] whileTrue:[
		(codeString at:objectStartPos) =$( ifTrue:[ 
												balanced := balanced -1.
												trail := trail , ')'].
		(codeString at:objectStartPos) =$) ifTrue:[balanced := balanced +1].
		
		(codeString at:objectStartPos) =$[ ifTrue:[
												balanced := balanced -1.
												trail := trail , '] value'].
		(codeString at:objectStartPos) =$] ifTrue:[balanced := balanced +1.].
		
		objectStartPos := objectStartPos - 1.
		followLoop := (objectStartPos >=1 and:[(codeString at:objectStartPos) =$: and:[balanced <= 0]]) not.
		].
	interestingCode := (codeString copyFrom:objectStartPos + 1 to: cursorPos).
	
	
	lastSpace := interestingCode findLastOccurrenceOfString: ' ' startingAt: 1.
	lastSpace >0 
		ifTrue:[
			objectPart := (interestingCode copyFrom: 1 to: lastSpace). 
			balanced <0 ifTrue:[ objectPart := objectPart , trail].
			messagePart  := (interestingCode copyFrom: lastSpace to: interestingCode size) trimBoth.
		] ifFalse:[
			objectPart := interestingCode.
			messagePart  := ''].
	previousCodePos := objectStartPos.

	[ previousCodePos>1 and:[ ($.= (codeString at:previousCodePos)) not ]] whileTrue:[previousCodePos := previousCodePos - 1].
	previousCode := codeString copyFrom:1 to: previousCodePos.
	codeForOjectType  :=  self guessObjectCode: objectPart
	

]

{ #category : #private }
IPVSAutoCompleter >> shouldBeAClass [ 

	^ (messagePart = '' and:[(objectPart endsWith: ' ') not]) 
	or:[objectPart trimBoth  = '' and:[messagePart ~= ''] ]
]

{ #category : #private }
IPVSAutoCompleter >> stopChars [
	^ #($. $=)
]
