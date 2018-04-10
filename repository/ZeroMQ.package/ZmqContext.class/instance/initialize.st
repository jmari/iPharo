initialization
initialize 
	super initialize.
	api := ZmqApi forCurrentVersion.
	resources := WeakSet new.
	parked := false.
	monitor := Monitor new.

	