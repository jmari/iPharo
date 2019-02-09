accessing
toggleButtonsStyle
	|i|
	i := IPWidget new model: IPToggleButtonsStyleModel  newInstance.
	^ self openCommFor:i.