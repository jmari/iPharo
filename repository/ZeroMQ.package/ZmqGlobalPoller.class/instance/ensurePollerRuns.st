as yet unclassified
ensurePollerRuns
	pollerProcess ifNil: [ self startPolling ]