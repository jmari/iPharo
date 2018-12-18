accessing
selectMultiple
	|i|
	i := IPWidget new model: IPSelectMultipleModel  newInstance.
	^ self openCommFor:i.