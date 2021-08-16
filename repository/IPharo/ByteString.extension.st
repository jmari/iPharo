Extension { #name : #ByteString }

{ #category : #'*IPharo-Core' }
ByteString >> asJupyterDataWithExtent: size [
	^ 'text/html'-> ('<pre>',(self asString  copyReplaceAll: String cr with: '<br/>'),'</pre>') 
]
