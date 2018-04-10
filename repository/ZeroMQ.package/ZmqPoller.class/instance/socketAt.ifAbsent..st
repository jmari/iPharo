as yet unclassified
socketAt: anInteger ifAbsent: aBlock
	self critical: [ ^ positionToSocketLookup at: anInteger ifAbsent: aBlock ]