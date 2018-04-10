helpers
addInteractions: aShape

	aShape isNil ifTrue: [ ^ self ].
	(aShape isKindOf: RTAnnounceableObject) ifFalse: [ ^ self ].
	stream nextPutAll: 'ints: '.
	self visitInteractions: aShape.
	stream nextPutAll: ', '