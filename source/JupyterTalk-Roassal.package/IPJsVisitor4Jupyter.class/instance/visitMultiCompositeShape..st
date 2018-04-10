visitor
visitMultiCompositeShape: aShape
	stream nextPutAll: '
		{id: "';
		nextPutAll: (self nameFor: aShape);
		nextPutAll: '", type:"multi", shapes:['.
	aShape shapes do: [ :s| s accept: self].
	stream nextPutAll: '], offsets: ['.
	aShape offsets do: [ :o | 
		stream nextPutAll: '{x: ';
			nextPutAll: (self number: o x);
			nextPutAll: ', y: ';
			nextPutAll: (self number: o y);
			nextPutAll: '},' ].
	
	stream nextPutAll: ']'.

	(aShape element isNil not and: [aShape element shape isKindOf: RTMultiColoredLine]) ifTrue: [ 
		self visitAttachPoint: aShape element. ].
	stream nextPutAll: '},'.