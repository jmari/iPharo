helpers
addColorBase: c
	stream 
		nextPutAll: '{r:';
		nextPutAll: (self number: (c red*255) rounded);
		nextPutAll: ',g:';
		nextPutAll: (self number: (c green*255) rounded);
		nextPutAll: ',b:';
		nextPutAll: (self number: (c blue*255) rounded).
	c alpha = 1 ifTrue: [ stream nextPutAll: '}' ]
	ifFalse: [ stream 
		nextPutAll: ',a:';
		nextPutAll: (self number: c alpha);
		nextPutAll: '}' ]