*JupyterTalk-Roassal
asJupyterDataWithExtent: size
	| morph |

	morph := self  canvas 
					color:Color transparent;
					buildMorph.
	
	morph 	extent:size.
	self  canvas camera focusOnCenterScaled:size.
	^  morph asJupyterDataWithExtent:size