Extension { #name : #Dictionary }

{ #category : #'*IPharo-Core' }
Dictionary >> asJupyterDataWithExtent:aPoint [
	|c|
	
	c := OrderedCollection new.
	c add: #( #key #value ).	
	self keysAndValuesDo: [ :k :v | c add: { k. v} ]. 

	^ c asJupyterDataWithExtent:aPoint
]
