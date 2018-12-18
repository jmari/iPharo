accessing
toggleButtons
	|i|
	i := IPWidget new model: IPToggleButtonsModel newInstance.
	^ self openCommFor:i.