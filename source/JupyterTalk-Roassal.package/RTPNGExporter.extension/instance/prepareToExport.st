*JupyterTalk-Roassal
prepareToExport
	| trachelCanvas  surface viewExtent |
	trachelCanvas := self trachelCanvas.
	viewExtent := self viewExtent.
	surface := self createSurface.
	surface
		drawDuring: [ :cs | 
			"Probably not necessary since we have just created a surface"
			surface clear;
				fillRectangle: (0@0 corner: viewExtent) withSolidColor: view canvas color.
			cs pathTransform
				translateBy: self viewHalfExtent asFloatPoint;
				scaleBy: self cameraScale;
				translateBy: self cameraPositionNegated asFloatPoint.
			trachelCanvas shapes do: [ :trachelShape | trachelShape drawOn: cs ].
			cs pathTransform loadIdentity scaleBy: 1.001.
			"trachelCanvas fixedShapes do: [ :trachelShape | trachelShape drawOn: cs ]" ].
	