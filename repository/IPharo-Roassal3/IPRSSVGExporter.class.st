Class {
	#name : #IPRSSVGExporter,
	#superclass : #RSSVGExporter,
	#category : #'IPharo-Roassal3'
}

{ #category : #visiting }
IPRSSVGExporter >> visitCanvas: aRSCanvas [ 
	| extent |
	pathTransform := AthensAffineTransform new.
	extent := aRSCanvas extent.
	pathTransform
		translateBy: (extent / 2) asFloatPoint;
		scaleBy: aRSCanvas camera scale asFloat;
		translateBy: aRSCanvas camera position negated asFloatPoint.
	self 
		write: '<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="'.
	self stream
		<< extent x asSVGString;
		<< 'pt" height="';
		<< extent y asSVGString;
		<< 'pt" viewBox="0 0 ';
		<< extent x asSVGString;
		<< ' ';
		<< extent y asSVGString;
		<< '" style="background-color:#';
		<< canvas color asHexString.
	self write: '" version="1.1"><g>
'.

	self writeLabelDefinitionsIfNecessary: aRSCanvas.
	aRSCanvas shapes do: [ :shape | shape accept: self ].
	self write: '</g></svg>'.
]
