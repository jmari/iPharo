visitor
visitAttachPoint: element index: index
	| ap |
	element ifNil: [ 
		^ stream nextPutAll: ',ap:RTCenteredAttachPoint' ].
	ap := element shape class = RTCompositeShape 
		ifTrue: [ element shape allShapes at: index ] 
		ifFalse: [ "Too ugly but work for this special case"
			(element shape class = RTDoubleArrowedLine and: [index = 3])
				ifTrue: [ element shape headEnd ]
			 	ifFalse: [ element shape ] ].
	stream nextPutAll: ',ap: new ';
		nextPutAll: ap attachPoint class name;
		nextPutAll: '(';
		nextPutAll: ap attachPoint isInverted asString;
		nextPutAll: ')'.
	
	