system startup
reinitialize
	monitor
		critical: [ 
			socketPointer := self newSocketPointer.
			parked := false.
			associations do: [ :association | association associateSocket: self ].			
			monitor signalAll ]