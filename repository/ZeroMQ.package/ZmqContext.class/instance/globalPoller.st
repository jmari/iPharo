as yet unclassified
globalPoller
	^ globalPoller ifNil:[	globalPoller := ZmqGlobalPoller new ]