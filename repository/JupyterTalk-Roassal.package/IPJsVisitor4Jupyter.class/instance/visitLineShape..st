visitor
visitLineShape: aLine
	
	| e fromTo |
	e := aLine element.
	fromTo := e 
		ifNil: [ '", fromid: ',(self pointToString: aLine from),',toid:',(self pointToString: aLine to),',' ]
		ifNotNil: [ '",fromid:<1p>,toid:<2p>,' 
			expandMacrosWith: (self nameFor: e from trachelShape)
			with: (self nameFor: e to trachelShape) ].
	
	stream nextPutAll: '
		{type: "line", id: "';
		nextPutAll: (self nameFor: aLine);
		nextPutAll: fromTo.
	self addColor: aLine color.
	stream nextPutAll: ' width: ';
		nextPutAll: (self number: aLine width).
	self visitAttachPoint: e.
	stream nextPutAll: '},'.
	