*JupyterTalk-Roassal
asJupyterInteractiveDataWithExtent:size

	self build.
	self view canvas buildMorph.
	^ self view asJupyterInteractiveDataWithExtent: size
	
