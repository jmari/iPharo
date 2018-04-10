initialization
initialize
	names := Dictionary new.
	validInteractions := #(#RTDraggableView #RTDraggable #RTPopup 
	#RTHighlightable #RTLabeled #RTShowEdge #RTShowLabel #RTZoomableView
	#RTFocusElement #RTLinkView).
	self exportFixedShapes: true.
	self stream: (WriteStream on: String new).
	self maxSize: 500.