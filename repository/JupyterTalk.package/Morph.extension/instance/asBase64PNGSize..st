*JupyterTalk-Core
asBase64PNGSize: scale  
	| aStream exporter|
	aStream := ReadWriteStream on: ByteArray new. 
	exporter := RTPNGExporter new. 
	exporter viewExtent closeTo:scale. 
	PNGReadWriter putForm: self imageForm  onStream: aStream.
	aStream reset.
	^ (Base64MimeConverter mimeEncode: aStream multiLine:false) contents