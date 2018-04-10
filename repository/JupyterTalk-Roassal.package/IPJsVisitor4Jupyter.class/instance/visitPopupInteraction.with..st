visitor-interactions
visitPopupInteraction: anInt with: el
	| elements |
	[elements := anInt createPopupFor: el] 
		on: Error do: [ ^ self ].
		
	stream nextPutAll: 'new RTPopup(['.
	elements do: [ :e | 
		e trachelShape element: e.
		e trachelShape accept: self ].
	stream nextPutAll: ']) '.