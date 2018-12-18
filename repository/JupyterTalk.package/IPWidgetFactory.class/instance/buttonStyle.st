accessing
buttonStyle
	|i|
	i := IPWidget new model: IPButtonStyleModel newInstance.
	^ self openCommFor:i.