*JupyterTalk-Roassal
asRoassalView
	| view  operations lab nodes edges |
	view :=  RTView new.
	operations := self allOperations.
	lab := RTLabel new.
	nodes := (RTEllipse new
				size: 15;
				color: (Color blue alpha: 0.4)) + (lab text: [ :op | op name ]) elementsOn: operations.
	nodes @ RTDraggable.
	view @ RTDraggableView @RTZoomableView.
	
	view addAll:nodes.

	edges := OrderedCollection new.
	operations
				do: [ :op | 
					| nbInputs output op1 op2 |
					nbInputs := op inputsCount.
					0 to: nbInputs - 1 do: [ :index | 
						output := TensorFlowCAPI uniqueInstance operationInput: (op input: index).
						op1 := TF_Operation fromHandle: output operation.
						op2 := (operations select: [ :opx | opx name = op1 name ]) at: 1.
						edges add: op2 -> op ] ].
	RTEdgeBuilder new
				view: view;
				shape:
					(RTArrowedLine new
						color: Color black);
				source: edges connectFrom: #key to: #value.
	(RTLayoutBuilder new forceWithCharge: -600) on: view elements.

	^ view