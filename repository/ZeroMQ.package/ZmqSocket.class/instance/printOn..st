as yet unclassified
printOn: aStream
	aStream nextPutAll: self socketTypeName.
	aStream nextPut:$(.
	aStream nextPutAll: (',' join: associations).
	aStream nextPut:$).