accessing
progressStyle
	|i|
	i := IPWidget new model: IPProgressStyleModel newInstance.
	^ self openCommFor:i.