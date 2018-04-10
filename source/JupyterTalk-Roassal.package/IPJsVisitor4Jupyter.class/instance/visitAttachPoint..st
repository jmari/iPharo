visitor
visitAttachPoint: element
	| ap |
	element ifNil: [ 
		^ stream nextPutAll: ',ap:RTCenteredAttachPoint' ].
	ap := element shape class = RTCompositeShape 
		ifTrue: [ element shape allShapes first ] 
		ifFalse: [ element shape ].
	stream nextPutAll: ',ap: new ';
		nextPutAll: ap attachPoint class name;
		nextPutAll: '(';
		nextPutAll: ap attachPoint isInverted asString;
		nextPutAll: ')'.
	