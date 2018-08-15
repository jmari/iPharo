tests
testAutocomplete

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new. a '  pos: 29. 
	
	methods :=((OrderedCollection allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(OrderedCollection selectors);
						yourself).
						
	list2 := (methods select:[:element|  ('' ,'*') match: element ] ) asSet asArray sort.


	self assert: (list at:1) equals:list2
	
