Extension { #name : #Object }

{ #category : #'*IPharo-Core' }
Object >> asJupyterDataWithExtent: size [
	^ { 'text/plain'-> self asString } asSCJsonObject 
]
