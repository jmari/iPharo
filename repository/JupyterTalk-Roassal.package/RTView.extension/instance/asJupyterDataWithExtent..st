*JupyterTalk-Roassal
asJupyterDataWithExtent: size
	| morph |
	morph:=self canvas 
			color:Color transparent;
			buildMorph.
	^ morph asJupyterDataWithExtent: size 