as yet unclassified
pollSocket: aZmqSocket forEvents: aZmqEventFilter
	self critical: [ ^ self pollSocket: aZmqSocket eventMask: aZmqEventFilter eventMask ]