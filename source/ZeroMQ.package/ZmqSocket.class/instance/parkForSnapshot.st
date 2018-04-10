system startup
parkForSnapshot
	monitor
		critical: [ 
			parked := true.
			self privateClose.
			]