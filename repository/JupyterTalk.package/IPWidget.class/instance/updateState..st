remote-update
updateState: aJsonDict
	| oldValue event newValue|
	aJsonDict keys do:[:k| 
		oldValue :=self model state at: k.
		newValue := (aJsonDict at:k).
		self model state at:k put: newValue.
		(oldValue = newValue) ifFalse:[
			event :=self notifyChangeInState: k
						oldValue: oldValue
						newValue: newValue.
			newValue := event newValue].
		self model state at:k put: event newValue.
		"if you Change the value in the event, it must be notofy to the client"
		event newValue = newValue ifFalse:[self sendUpdate:( k -> event newValue)] ]
		