visitor-interactions
visitDraggableInteraction: anInteraction with: anObject
	| list trachelBlock nest |
	list := OrderedCollection new.
	(anObject attributes includesKey: #RTLabelledLabel) ifTrue: [  
		list add: (anObject attributes at: #RTLabelledLabel).
	].
	nest := nil.
	nest := [ :ob | 
		(ob attributes includesKey: #nestedElements) ifTrue: [ 
			(ob attributes at: #nestedElements) do: [ :e|
				e isCollection 
					ifTrue: [ list addAll: (e collect: [:x | nest value: x. x trachelShape ]) ]
					ifFalse: [ nest value: e. list add: e trachelShape ] ] ].
		].
	nest value: anObject.
	
	trachelBlock := [ :e|	(e isKindOf: TRShape) ifTrue: [ e ] ifFalse: [ e trachelShape ] ].
	list addAll: (anInteraction groupToDrag collect: trachelBlock).
	list isEmpty ifTrue: [ self visitInteraction: anInteraction with: anObject ]
	ifFalse: [
		stream nextPutAll: 'new RTDraggable(['.
		list do: [ :e | 
			stream nextPutAll: '"';
				nextPutAll: (self nameFor:e);
				nextPutAll: '", ' ].
			stream nextPutAll: '])'.
	]
	