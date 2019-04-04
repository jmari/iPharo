Extension { #name : #RTView }

{ #category : #'*JupyterTalk-Roassal' }
RTView >> asJupyterDataWithExtent: size [
	| morph |

	morph := self  canvas 
					color:Color transparent;
					buildMorph.
	
	morph 	extent:size.
	self  canvas camera focusOnCenterScaled:size.
	^  morph asJupyterDataWithExtent:size
]

{ #category : #'*JupyterTalk-Roassal' }
RTView >> asJupyterInteractiveDataWithExtent: size [
	| aStream morph |
	self build.
	morph := self view canvas 			
				color:Color transparent;
				buildMorph .
	aStream := ReadWriteStream on: String new. 
	morph 	extent:size.
	self canvas camera focusOnCenterScaled:size.
	IPRoassal new export:self view toStream:aStream.
	
	aStream reset.
	^ 'text/html' -> aStream contents

]
