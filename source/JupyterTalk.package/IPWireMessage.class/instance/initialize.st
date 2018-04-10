initialization
initialize
	super initialize.
	wireMessage := Array new:7.
	wireMessage from: 1 to: 7 put: ByteArray new.
	currentProperty := 1