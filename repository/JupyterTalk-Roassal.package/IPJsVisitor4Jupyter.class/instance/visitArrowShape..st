visitor
visitArrowShape: arrowShape
	| e |
	e := arrowShape element.
	stream nextPutAll: '
		{type: "simplearrow", id: "';
		nextPutAll: (self nameFor: arrowShape).
	stream 
		nextPutAll: '", fromid: ''';
		nextPutAll: (self nameFor: e from trachelShape);
		nextPutAll: ''', toid: ''';
		nextPutAll: (self nameFor: e to trachelShape);
		nextPutAll: ''','.
		
	self addColor: arrowShape strokePaint.
	stream
		nextPutAll: ' width: ';
		nextPutAll: (self number: arrowShape width);
		nextPutAll: ', size: ';
		nextPutAll: (self number: arrowShape mySize);
		nextPutAll: ', percentage: ';
		nextPutAll: (self number: arrowShape percentage).
	self visitAttachPoint: e trShape: arrowShape.
	stream 
		nextPutAll: ', base: ';
	 	nextPutAll: (self number: arrowShape baseSize);
		nextPutAll: '},'.