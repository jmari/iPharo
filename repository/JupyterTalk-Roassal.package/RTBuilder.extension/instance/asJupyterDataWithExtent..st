*JupyterTalk-Roassal
asJupyterDataWithExtent:size
	| aStream |
	self build.
	self view canvas buildMorph .
	aStream := ReadWriteStream on: ByteArray new. 
	self view canvas color:Color transparent.
   ^  self view canvas morph asJupyterDataWithExtent:size
	