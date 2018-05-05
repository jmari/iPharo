*JupyterTalk-Core
asBase64PNGSize: size  
	| aStream |

	self extent:size.
	aStream := ReadWriteStream on: ByteArray new. 
	PNGReadWriter putForm: self imageForm  onStream: aStream.
	aStream reset.
	^ (Base64MimeConverter mimeEncode: aStream multiLine:false) contents