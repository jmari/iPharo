queries
dataAvailable
	self logDebug: 'There is data available.'.
	resultHandler ifNil:[self logDebug: 'Data available, but no handler'] ifNotNil:[self receiveIfAvailable:[:data| resultHandler cull: data] ].