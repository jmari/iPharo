Extension { #name : #Object }

{ #category : #'*JupyterTalk-Core' }
Object >> asJupyterDataWithExtent: size [
	^ 'text/plain'-> self asString  
]
