system startup
reinitialize
	monitor
		critical: [ 
			parked := false.
			resources do: [ :resource | resource reinitialize ].
			globalPoller ifNotNil: [globalPoller reinitialize].
			monitor signalAll.
			
			]