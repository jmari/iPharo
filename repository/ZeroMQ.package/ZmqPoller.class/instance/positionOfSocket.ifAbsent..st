as yet unclassified
positionOfSocket: aZmqSocket ifAbsent: aBlock
	self critical: [ ^ socketToPositionLookup at: aZmqSocket ifAbsent: aBlock ]