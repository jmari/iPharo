visitor-interactions
visitHightlightableInteraction: anInt with: el
	stream nextPutAll: 'new RTHighlightable({'.
	self addColor: anInt highlightedColor.
	stream nextPutAll: 'ides: ['.
		((anInt highlightElements) rtValue: el) 
		do: [ :e |
			stream 
				nextPutAll: '"';
				nextPutAll: (self nameFor: e trachelShape);
				nextPutAll: '",' ].
		stream nextPutAll: ']})'.