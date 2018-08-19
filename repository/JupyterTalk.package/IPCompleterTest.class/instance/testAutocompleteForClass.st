tests
testAutocompleteForClass

	| list list2 methods |
	list := self testAutocomplete: 'OrderedCollection'  pos: 17. 
	
	methods :=((OrderedCollection class allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection class selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('' ,'*') match: element ] ) asSet asArray sort.


	self assert: (list at:1) equals:list2
	
