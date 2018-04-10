initialization
initialize 
	super initialize.
	associations := OrderedCollection new.
	parked := false.
	monitor := Monitor new.