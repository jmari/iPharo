Extension { #name : #RSCanvas }

{ #category : #'*IPharo-Roassal3' }
RSCanvas >> asJupyterDataWithExtent: size [
	^ self asSvgWithExtent: size
]

{ #category : #'*IPharo-Roassal3' }
RSCanvas >> asSvgWithExtent: size [
	| svgStream |
	svgStream := WriteStream on:String new.
	self svgExporter exportToStream: svgStream.
	^ 'image/svg+xml' -> svgStream contents 
]
