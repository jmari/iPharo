instance creation
session: sessionId

	^ self sessions 
			at: sessionId 
			ifAbsent:[ ZmqLog logDebug: 'Session ', sessionId,' not found'. nil ]

									