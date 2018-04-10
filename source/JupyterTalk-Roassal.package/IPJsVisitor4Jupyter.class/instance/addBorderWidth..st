helpers
addBorderWidth: aShape
	(aShape strokePaint isNil or: [ aShape strokeWidth < 0 ]) ifTrue: [ ^ self ].
	stream 
		nextPutAll: 'sw: ';
		nextPutAll: (self number: aShape strokeWidth);
		nextPutAll: ','.