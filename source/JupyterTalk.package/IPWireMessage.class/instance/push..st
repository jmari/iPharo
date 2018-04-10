initialization
push: aProperty
	currentProperty <= wireMessage size ifTrue:[wireMessage at:currentProperty put:aProperty].
	currentProperty := currentProperty + 1
	