system startup
shutDown
	instance ifNotNil: [instance parkForSnapshot].
	Smalltalk garbageCollect.
	