accessing
getProperty: aProperty
	^ (self stateIncludesKey:aProperty) 
		ifTrue:[ self model state at:aProperty]
		ifFalse:[MessageNotUnderstood signal: aProperty, ' could not be found']