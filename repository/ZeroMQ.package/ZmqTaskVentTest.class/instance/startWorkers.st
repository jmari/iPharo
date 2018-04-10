initialization
startWorkers
	workers := OrderedCollection new.
	1 to: self numberOfWorkers do:[:w|
		workers add: self newWorker.
	]	
