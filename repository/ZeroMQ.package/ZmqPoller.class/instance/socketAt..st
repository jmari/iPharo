as yet unclassified
socketAt: anInteger
	self critical: [ ^ self socketAt: anInteger ifAbsent: [ Error signal: 'Unkown socket' ] ]