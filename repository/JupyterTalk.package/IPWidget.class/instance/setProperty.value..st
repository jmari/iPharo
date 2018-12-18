accessing
setProperty: aProperty value: aValue
	| oldValue event aValueCanBeChanged|
	(self stateIncludesKey:aProperty) 
		ifFalse:[MessageNotUnderstood signal: aProperty, ' could not be found']
		ifTrue:[
			oldValue :=self model state at: aProperty.
			event := nil.
			aValueCanBeChanged := aValue.
			self model state at: aProperty put: aValue.
			(oldValue = aValue) ifFalse:[
										event:= self notifyChangeInState: aProperty
														oldValue:oldValue
														newValue:aValue.
										self model state at: aProperty put: event newValue.
										aValueCanBeChanged := event newValue].
			self sendUpdate:( aProperty -> aValueCanBeChanged)]