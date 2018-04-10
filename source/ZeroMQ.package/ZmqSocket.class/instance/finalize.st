finalization
finalize 
	ZmqLog logDebug: 'Closing socket'.
	self close.
	ZmqLog logDebug: 'Closed socket'.
	super finalize.