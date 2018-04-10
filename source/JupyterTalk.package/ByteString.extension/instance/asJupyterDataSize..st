*JupyterTalk-Core
asJupyterDataSize: size
	^ 'text/html'-> ('<pre>',(self asString  copyReplaceAll: String cr with: '<br/>'),'</pre>') 