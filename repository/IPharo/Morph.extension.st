Extension { #name : #Morph }

{ #category : #'*IPharo-Core' }
Morph >> asBase64PNGSize: size [  
	| aStream |

	size ifNotNil:[self extent:size].
	aStream := ReadWriteStream on: ByteArray new. 
	PNGReadWriter putForm: self imageForm  onStream: aStream.
	aStream reset.
	^ (Base64MimeConverter mimeEncode: aStream multiLine:false) contents
]

{ #category : #'*IPharo-Core' }
Morph >> asJupyterDataWithExtent: size [
	^ 'image/png' -> (self asBase64PNGSize:size  )
]
