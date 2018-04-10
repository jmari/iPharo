as yet unclassified
receiveAndWait
	|msg|
	msg := nil.
	[ msg notNil and:[msg size > 0] ] whileFalse:[ 
							msg := self receiveIfAvailable.
							Processor yield ].
	^ msg
		