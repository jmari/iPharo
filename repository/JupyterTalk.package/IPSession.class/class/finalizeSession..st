accessing
finalizeSession: sessionId
	self sessions removeKey: sessionId ifAbsent:[
							ZmqLog logDebug: 'Session ', sessionId ,' not found' ]