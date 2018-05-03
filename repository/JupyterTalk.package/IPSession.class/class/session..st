instance creation
session: sessionId

	^ self currentSession id = sessionId
			ifTrue:[self currentSession value]
			ifFalse:[ ZmqLog logDebug: 'Session ', sessionId,' not found'. nil ]

									