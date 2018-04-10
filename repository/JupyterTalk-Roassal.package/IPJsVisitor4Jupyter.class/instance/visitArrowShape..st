visitor
visitArrowShape: arrowShape
	| e |
	e := arrowShape element.
	stream nextPutAll: '
		{type: "simplearrow", id: "';
		nextPutAll: (self nameFor: arrowShape);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	self addColor: arrowShape strokePaint.
	stream
		nextPutAll: ' width: ';
		nextPutAll: (self number: arrowShape width);
		nextPutAll: ', size: ';
		nextPutAll: (self number: arrowShape mySize).
	self visitAttachPoint: e.
	stream 
		nextPutAll: ', base: ';
	 	nextPutAll: (self number: arrowShape baseSize);
		nextPutAll: '},'.
	