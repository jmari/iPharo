Extension { #name : #RTBuilder }

{ #category : #'*JupyterTalk-Roassal' }
RTBuilder >> asJupyterDataWithExtent:size [
	
	self build.	
   ^  self view asJupyterDataWithExtent:size
	
]

{ #category : #'*JupyterTalk-Roassal' }
RTBuilder >> asJupyterInteractiveDataWithExtent:size [

	self build.
	^ self view asJupyterInteractiveDataWithExtent: size
	

]
