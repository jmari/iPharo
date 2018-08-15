as yet unclassified
getCodeForObject: className
 ^ '((' , className , ') class = UndefinedObject )
	ifTrue:[Error signal:''foo'']
	ifFalse:[
			(' , className , ') class]'.