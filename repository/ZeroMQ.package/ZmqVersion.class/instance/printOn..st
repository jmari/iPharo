printing
printOn: aStream
	aStream nextPutAll: self major asString.
	aStream nextPut: $..
	aStream nextPutAll: self minor asString.	
	aStream nextPut: $..
	aStream nextPutAll: self patch asString.	

	