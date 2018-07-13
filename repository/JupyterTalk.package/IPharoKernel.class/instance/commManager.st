comm handlers
commManager
	^ commManager ifNil:[commManager := IPCommManager new ]