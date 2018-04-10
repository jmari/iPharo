private-api conveniency
signalErrno: errno
	| msg |
	msg := 'ZMQ Error: ' , (self zmqErrnoAsString: errno).
	ZmqLog logError: msg.
	Error signal: msg