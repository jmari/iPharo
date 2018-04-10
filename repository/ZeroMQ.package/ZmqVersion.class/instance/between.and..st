testing
between: min and: max
	^ self >= (self toVersion: min) and: [ self <= (self toVersion: max) ]