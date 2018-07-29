initialization
initialize
	super initialize.
	poller := ZmqPoller onContext: self context.