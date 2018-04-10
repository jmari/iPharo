visitor
visitBezierShape: aBezierShape
	| e shape |
	e := aBezierShape element.
	shape := (e shape class = RTCompositeShape) ifTrue: [ shape := e shape allShapes first ] ifFalse: [ e shape ].
	stream nextPutAll: '
		{type: "bezier", id: "';
		nextPutAll: (self nameFor: aBezierShape);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	self addColor: aBezierShape strokePaint.
	
	shape class = RTBezierLine ifTrue: [ 
		stream 
			nextPutAll:  'tension: ';
			nextPutAll: (self number: shape tension);
			nextPutAll: ', ides: ['.
		shape follow ifNotNil: [ shape setControllingElementsFromFollowFor: e ].
		(shape controllingElements rtValue: e) do: [ :el | 
			stream 
				nextPutAll: '"';
				nextPutAll: (self nameFor: el trachelShape);
				nextPutAll: '", '] ].
	
	stream nextPutAll: '], width: ';
		nextPutAll: (self number: aBezierShape width).
	self visitAttachPoint: e.
	stream nextPutAll: '},'.
	