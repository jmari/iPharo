as yet unclassified
guessObjectCode: codeForObject
 ^ '((' , codeForObject , ') class = UndefinedObject )
	ifTrue:[Error signal:''foo'']
	ifFalse:[
			(' , codeForObject , ') class]'.