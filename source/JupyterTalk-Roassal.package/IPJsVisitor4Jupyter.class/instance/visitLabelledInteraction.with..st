visitor-interactions
visitLabelledInteraction: anInt with: el
	stream nextPutAll: 'new RTLabelled({'.
		self addColor: anInt color.
		stream nextPutAll: 'low'.
		self addColor: anInt lowColor.
		stream 
			nextPutAll: 'lbl: ';
			nextPutAll: '"';
			nextPutAll: (self nameFor: anInt lbl);
			nextPutAll: '"})'.