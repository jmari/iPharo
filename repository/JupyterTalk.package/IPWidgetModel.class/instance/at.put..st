accessing
at:key put: value
	super at:key put:value.
	self changed: (key -> value)