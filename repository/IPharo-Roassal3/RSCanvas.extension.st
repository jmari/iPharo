Extension { #name : #RSCanvas }

{ #category : #'*IPharo-Roassal3' }
RSCanvas >> asJupyterDataWithExtent: aPoint [
	^ self asSvgWithExtent: aPoint
]

{ #category : #'*IPharo-Roassal3' }
RSCanvas >> asSvgWithExtent: aPoint [
	| svgStream |
	svgStream := WriteStream on:String new.
	self extent: aPoint.
	self ipSvgExporter exportToStream: svgStream.
	^ {'text/html' -> svgStream contents } asSCJsonObject 
]

{ #category : #'*IPharo-Roassal3' }
RSCanvas >> ipSvgExporter [
	^ IPRSSVGExporter new
			canvas: self;
			yourself
]
