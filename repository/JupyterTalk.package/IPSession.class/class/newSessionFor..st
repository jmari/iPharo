accessing
newSessionFor: aHeader

	currentSession :=
			(aHeader session) -> (self new 
							username: aHeader username;
							id: aHeader session;
							startTime: aHeader timestamp).
	^ currentSession value
		
									