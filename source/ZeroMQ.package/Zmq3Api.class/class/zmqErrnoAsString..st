as yet unclassified
zmqErrnoAsString: errno
	^ errno asString , ': ' , (self apiZmqStrError: errno)