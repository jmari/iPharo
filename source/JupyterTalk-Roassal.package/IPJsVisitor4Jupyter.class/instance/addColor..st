helpers
addColor: c
	stream nextPutAll: 'color: '.
	self addColorBase: c.
	stream nextPutAll: ', '.
	