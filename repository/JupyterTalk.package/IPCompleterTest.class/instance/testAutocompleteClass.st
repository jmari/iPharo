tests
testAutocompleteClass

	| list list2 |
	list := self testAutocomplete: 'a:=OrderedCollec'  pos: 16. 
	
	list2 := {'OrderedCollection'. 'OrderedCollectionTest'}.
	
	self assert: (list at:1) equals:list2
	
