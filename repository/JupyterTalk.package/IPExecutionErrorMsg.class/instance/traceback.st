as yet unclassified
traceback
	|aStream|
	aStream := ReadWriteStream on:String new.

	self exceptionObject signalerContext errorReportOn: aStream.

	^ aStream contents substrings: Character cr asString