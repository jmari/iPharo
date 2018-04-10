visitor
visitLabelShape: aLabel
	| box |
	box := aLabel basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "label", id: "';
		nextPutAll: (self nameFor: aLabel);
		nextPutAll: '",o: {x: ';
		nextPutAll: (self number: box origin x);
		nextPutAll: ', y: ';
		nextPutAll: (self number: box origin y);
		nextPutAll: '},c: {x: ';
		nextPutAll: (self number: box corner x);
		nextPutAll: ', y: ';
		nextPutAll: (self number: box corner y);
		nextPutAll: '},'.
	self addColor: aLabel color.
	self addStringWithFont: aLabel.
	self addInteractions: aLabel element.
	self addMatrix: aLabel matrix.
