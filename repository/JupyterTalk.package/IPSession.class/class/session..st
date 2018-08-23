instance creation
session: sessionId

	^ self currentSession id = sessionId
			ifTrue:[self currentSession value]
			ifFalse:[self newSessionFor: sessionId ]

									