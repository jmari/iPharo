compilation
hasBindingThatBeginsWith: aString
	^ bindings keys anySatisfy: [:each | each beginsWith: aString]