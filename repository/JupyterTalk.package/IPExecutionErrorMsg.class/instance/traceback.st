as yet unclassified
traceback
	|aStream|
	aStream := ReadWriteStream on:String new.
	aStream 
		nextPutAll: self exceptionObject asString;
		nextPutAll: String crlf.
	
	self exceptionObject signalerContext errorReportOn: aStream.

	^ aStream contents substrings: Character cr asString