event-handling
notifyChangeInState: k oldValue:oV newValue:nV
	|event|
	event := IPStateChangedEvent new 
								sender:self;
								oldValue: oV;
								newValue: nV.
	self listeners do:[:l|
		l valueWithEnoughArguments: {event}].
	^ event