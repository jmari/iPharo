visitor
visitPolygonShape: aPolygon
	| r c |
	r := aPolygon encompassingRectangle.
	c := aPolygon color.
	c ifNil: [ c:= Color transparent ].
	
	stream nextPutAll: '
		{type: "polygon", id: "';
		nextPutAll: (self nameFor: aPolygon);
		nextPutAll: ('", o: {x: ',(self number: r origin x),', y: ',(self number: r origin y),'}');
		nextPutAll: (', c: {x: ',(self number: r corner x),', y: ',(self number: r corner y),'}, p: "').
	
	aPolygon vertices do: [ :p |
		stream nextPutAll: (self number: p x),',',(self number: p y),' '. ].
	stream nextPutAll: '",'.
	self addBorderColor: aPolygon strokePaint.
	self addBorderWidth: aPolygon.
	self addColor: c.
	self addInteractions: aPolygon element.
	self addMatrix: aPolygon matrix.