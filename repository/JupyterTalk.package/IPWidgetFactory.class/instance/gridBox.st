accessing
gridBox
	|i|
	i := IPWidget new model: IPGridBoxModel newInstance.
	^ self openCommFor:i.