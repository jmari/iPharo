*JupyterTalk-Roassal
asJupyterDataWithExtent:size
	| morph |

	self build.	
	morph := self view canvas 
					color:Color transparent;
					buildMorph.
	
	morph 	extent:size.
	self view canvas camera focusOnCenterScaled:size.

	
   ^  morph asJupyterDataWithExtent:size
	