as yet unclassified
lastZmqError
	| errno |
	errno := self apiZmqErrno.
	^ (self zmqErrnoAsString: errno)