tests
testAutocompletePartOfMsgInsideMultipleParametersWithParenthesisBalanced

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.Transcript show:(a sort) so popo:'  pos: 53. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	