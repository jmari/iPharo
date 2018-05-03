*JupyterTalk-Core
asJupyterDataWithExtent:aPoint
	|c|
	c := Array 
				with: self keys
				with: self values.

	^ c asJupyterDataWithExtent:aPoint