as yet unclassified
initializeLookups
	positionToSocketLookup := positionToSocketLookup ifNotNil: [ :x | x removeAll ] ifNil: [ Dictionary new ].
	socketToPositionLookup := socketToPositionLookup ifNotNil: [ :x | x removeAll ] ifNil: [ IdentityDictionary new ]