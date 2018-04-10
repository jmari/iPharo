system startup
parkForSnapshot
	monitor
		critical: [ 
			globalPoller ifNotNil: [ globalPoller parkForSnapshot ].
			resources do: [ :resource | resource parkForSnapshot ].
			self privateTerminate.
			parked := true ]