as yet unclassified
printOn: aStream
	aStream nextPutAll: self associationTypeName.
	aStream nextPutAll: ':'.
	aStream nextPutAll: self target.
	