Class {
	#name : #IPCompleterTest,
	#superclass : #TestCase,
	#category : 'JupyterTalk-Tests'
}

{ #category : #initialization }
IPCompleterTest >> setUp [
	IPSession testSession
]

{ #category : #running }
IPCompleterTest >> tearDown [
]

{ #category : #tests }
IPCompleterTest >> testAutocomplete [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new. a '  pos: 29. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('' ,'*') match: element ] ) asSet asArray sort.


	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocomplete:code pos: pos [
	| aMessage completer list |
	aMessage := IPMsg new.
	completer := IPVSAutoCompleter new.
	aMessage content at:#code put: code.
	aMessage content at:#cursor_pos put: pos.
	aMessage header session:'TEST'.
	list := completer getCompletionListFrom: aMessage.
	
	^ list
	
]

{ #category : #tests }
IPCompleterTest >> testAutocompleteClass [

	| list list2 |
	list := self testAutocomplete: 'a:= OrderedCollec'  pos: 17. 
	
	list2 := {'OrderedCollection'. 'OrderedCollectionTest'}.
	
	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompleteForClass [

	| list list2 methods |
	list := self testAutocomplete: 'OrderedCollection '  pos: 18. 
	
	methods :=((OrderedCollection class allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection class selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('' ,'*') match: element ] ) asSet asArray sort.


	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompleteNoType [

	| list list2 methods |
	list := self testAutocomplete: 'a:= (Smalltalk at:#OrderedCollection) new so'  pos: 44. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompletePartOfMsg [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new. a so'  pos: 31. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompletePartOfMsgInsideMultipleParameters [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.Transcript show:a so'  pos: 46. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompletePartOfMsgInsideMultipleParametersWithBlockUnBalanced [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new. [a so'  pos: 32. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompletePartOfMsgInsideMultipleParametersWithParenthesi [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.Transcript show:(a so'  pos: 47. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testAutocompletePartOfMsgInsideMultipleParametersWithParenthesisBalanced [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.Transcript show:(a sort) so popo:'  pos: 53. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]

{ #category : #tests }
IPCompleterTest >> testWhatAppendIDontKnowKindOf [

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.b so'  pos: 30. 
	
	methods :=((Object allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(Object selectors);
						yourself).
				
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	

]
