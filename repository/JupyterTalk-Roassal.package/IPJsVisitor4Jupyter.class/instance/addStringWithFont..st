helpers
addStringWithFont: aLabel
	| converter fn |
	converter := RTSVGStringConverter new.
	fn := aLabel fontName.
	fn = 'Source Sans Pro' ifTrue: [ fn := 'Verdana, Geneva, sans-serif' ].
	stream nextPutAll: ' text: "';
		nextPutAll: (converter convertString: (aLabel text truncateTo: maxSize));
		nextPutAll: '", font: {n: "';
		nextPutAll: fn;
		nextPutAll: '", s: ';
		nextPutAll: (self number: aLabel fontSize);
		nextPutAll: '},'