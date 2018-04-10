*JupyterTalk-Roassal
asJupyterHTMLDataSize: size
	| aStream |
	self build.
	self view canvas buildMorph .
	aStream := ReadWriteStream on: String new. 
	IPRoassal new export:self view toStream:aStream.
	aStream reset.
	^ 'text/html' -> aStream contents
