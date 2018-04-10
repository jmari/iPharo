as yet unclassified
poll
	^ self poller pollEventsAndSocketsDo: [ :events :socket | events ifReadEvent: [ socket dataAvailable ] ]