visitor
visitRotatedLabelShape: aLabel
	| box matrix |
	box := aLabel basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "label", id: "';
		nextPutAll: (self nameFor: aLabel);
		nextPutAll: ('",o: {x: <1p>, y: <2p>},' expandMacrosWith: box origin x with: box origin y);
		nextPutAll: ('c: {x: <1p>, y: <2p>},' expandMacrosWith: box corner x with: box corner y).
	self addColor: aLabel color.
	self addStringWithFont: aLabel.
	self addInteractions: aLabel element.
	matrix := aLabel matrix copy.
	matrix rotateByDegrees: aLabel angle.
	self addMatrix: matrix.
