*JupyterTalk-Core
asBase64PNGSize: size  
	| aStream |
	aStream := ReadWriteStream on: ByteArray new. 
	self color:Color white.
	PNGReadWriter putForm: self imageForm  onStream: aStream.
	aStream reset.
	^ (Base64MimeConverter mimeEncode: aStream multiLine:false) contents