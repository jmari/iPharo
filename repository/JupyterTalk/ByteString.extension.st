Extension { #name : #ByteString }

{ #category : #'*JupyterTalk-Core' }
ByteString >> asJupyterDataWithExtent: size [
	^ 'text/html'-> ('<pre>',(self asString  copyReplaceAll: String cr with: '<br/>'),'</pre>') 
]
