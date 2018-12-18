accessing
intProgress
	|i|

	i := IPWidget new model: IPIntProgressModel newInstance.
	^ self openCommFor:i.