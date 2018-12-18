accessing
floatProgress
	|i|

	i := IPWidget new model: IPFloatProgressModel newInstance.
	^ self openCommFor:i.