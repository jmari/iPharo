*JupyterTalk-Roassal
asJupyterHTMLDataSize:size

	self build.
	self view canvas buildMorph.
	^ self view asJupyterHTMLDataSize: size
	
