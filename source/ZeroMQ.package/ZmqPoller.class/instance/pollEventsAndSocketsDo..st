as yet unclassified
pollEventsAndSocketsDo: aBlockClosure
	^ self pollFor: 0 milliSecond asDelay withEventsAndSocketsDo: aBlockClosure.