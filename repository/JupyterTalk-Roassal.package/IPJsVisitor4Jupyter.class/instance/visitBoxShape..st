visitor
visitBoxShape: aBox
	
	| box |
	box := aBox basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "box", id: "';
		nextPutAll: (self nameFor: aBox);
		nextPutAll: '", w: ';
		nextPutAll: (self number: box width);
		nextPutAll: ', h: ';
		nextPutAll: (self number: box height);
		nextPutAll: ', '.
	self addBorderColor: aBox strokePaint.
	self addBorderWidth: aBox.
	self addColor: aBox color.
	self addInteractions: aBox element.
	self addMatrix: aBox matrix.