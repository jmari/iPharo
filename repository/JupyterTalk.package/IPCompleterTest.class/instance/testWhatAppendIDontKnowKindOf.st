tests
testWhatAppendIDontKnowKindOf

	| list list2 methods |
	list := self testAutocomplete: 'a:= OrderedCollection new.b so'  pos: 30. 
	
	methods :=((Object allSuperclasses 
					flatCollect:[:aClass| aClass selectors]) 
						addAll:(Object selectors);
						yourself).
				
	list2 := (methods select:[:element|  ('so' ,'*') match: element ] ) asSet asArray sort.

	self assert: (list at:1) equals:list2
	
