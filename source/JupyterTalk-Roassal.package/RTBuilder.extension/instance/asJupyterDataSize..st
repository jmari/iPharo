*JupyterTalk-Roassal
asJupyterDataSize:size
	| aStream |
	self build.
	self view canvas buildMorph .
	aStream := ReadWriteStream on: ByteArray new. 

	PNGReadWriter putForm:  self view canvas morph imageForm   onStream: aStream.
	aStream reset.
	^ 'image/png' -> (Base64MimeConverter mimeEncode: aStream multiLine:false) contents
