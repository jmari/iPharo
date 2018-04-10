testing
hasEventMask: anInteger
	^(self revents bitAnd: anInteger) = anInteger