visitor-interactions
visitShowEdgeInteraction: anInt with: el
	|edges t |
	t := (anInt connectToElements rtValue: el).
	t := t copyWithout: nil.
	edges := (anInt shape rtValue: el) edgesFrom: el toAll: t.
	stream nextPutAll: 'new RTShowEdge(['.
	edges do: [ :e |
		e trachelShape element: e.
		e trachelShape accept: self ].
	stream nextPutAll: ']) '.