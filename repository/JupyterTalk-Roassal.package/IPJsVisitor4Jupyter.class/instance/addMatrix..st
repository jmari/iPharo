helpers
addMatrix: m
	stream 
		nextPutAll: 'matrix:{shx: ';
		nextPutAll: (self number: m shx);
		nextPutAll: 	',shy: ';
		nextPutAll: (self number: m shy);
		nextPutAll: 	',sx: ';
		nextPutAll: (self number: m sx);
		nextPutAll: 	',sy: ';
		nextPutAll: (self number: m sy);
		nextPutAll: 	',x: ';
		nextPutAll: (self number: m x);
		nextPutAll: ',y: ';
		nextPutAll: (self number: m y);
		nextPutAll: '}}, '.
	