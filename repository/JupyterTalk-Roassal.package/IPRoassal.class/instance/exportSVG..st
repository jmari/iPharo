helpers
exportSVG: aView
	| visitor |

	visitor := IPJsVisitor4Jupyter new uuid:self uuid.
	visitor maxSize: self maxSizeForString.
	visitor exportFixedShapes: self exportFixedShapes.
	visitor stream: stream.
	visitor visitView: aView.