accessing
toggleButton
	|i|
	i := IPWidget new model: IPToggleButtonModel newInstance.
	^ self openCommFor:i.