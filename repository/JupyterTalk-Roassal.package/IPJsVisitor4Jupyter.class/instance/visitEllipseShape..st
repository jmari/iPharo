visitor
visitEllipseShape: anEllipse	
	| box |
	box := anEllipse basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "ellipse", id: "';
		nextPutAll: (self nameFor: anEllipse);
		nextPutAll: '", rx: ';
		nextPutAll: (self number: box width / 2);
		nextPutAll: ', ry: ';
		nextPutAll: (self number: box height/2);
		nextPutAll: ','.
	self addBorderColor: anEllipse strokePaint.
	self addBorderWidth: anEllipse.
	self addColor: anEllipse color.
	self addInteractions: anEllipse element.
	self addMatrix: anEllipse matrix.