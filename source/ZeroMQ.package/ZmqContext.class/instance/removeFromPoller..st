as yet unclassified
removeFromPoller: aSocket
	globalPoller ifNotNil: [ globalPoller removeSocket: aSocket ]