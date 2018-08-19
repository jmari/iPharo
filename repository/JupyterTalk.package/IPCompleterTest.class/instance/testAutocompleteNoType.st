tests
testAutocompleteNoType

	| list list2 methods |
	list := self testAutocomplete: 'a:= (Smalltalk at:#OrderedCollection) new so'  pos: 44. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	
