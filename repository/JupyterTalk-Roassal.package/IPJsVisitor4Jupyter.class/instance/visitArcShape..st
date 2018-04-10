visitor
visitArcShape: aShape
	aShape topLeft ifNil: [ aShape computeRectangle ].
	stream nextPutAll: '
		{type: "arc", id: "';
		nextPutAll: (self nameFor: aShape);
		nextPutAll: '", ir: ';
		nextPutAll: (self number: aShape innerRadius);
		nextPutAll: ', er: ';
		nextPutAll: (self number: aShape externalRadius);
		nextPutAll:', aAngle: ';
		nextPutAll: (self number: aShape alphaAngle);
		nextPutAll: ', bAngle: ';
		nextPutAll: (self number: aShape betaAngle);
		nextPutAll: ', o: {x: ';
		nextPutAll: (self number: aShape topLeft x);
		nextPutAll: ', y: ';
		nextPutAll: (self number: aShape topLeft y);
		nextPutAll: '}, c: {x: ';
		nextPutAll: (self number: aShape bottomRight x);
		nextPutAll: ', y: ';
		nextPutAll: (self number: aShape bottomRight y );
		nextPutAll: '},'.
	self addColor: aShape color.
	self addInteractions: aShape element.
	self addMatrix: aShape matrix.
