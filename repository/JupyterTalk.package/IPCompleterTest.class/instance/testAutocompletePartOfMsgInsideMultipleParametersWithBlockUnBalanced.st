tests
testAutocompletePartOfMsgInsideMultipleParametersWithBlockUnBalanced

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new. [a so'  pos: 32. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	
