visitor
visitCanvas: aCanvas
	self exportFixedShapes ifFalse: [ ^ self ].
	aCanvas fixedShapes ifEmpty: [ ^ self ].
	stream nextPutAll:'	shapes = ['.
	aCanvas fixedShapes do: [ :s | s accept: self ].
	stream nextPutAll: '
	];
	mamani["', self uuid asString,'"].addFixedShapes(shapes);
'
	
	
