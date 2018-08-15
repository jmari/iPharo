tests
testSession
	currentSession :=
			'TEST' -> (self new 
							username: 'TEST';
							id: 'TEST';
							startTime: DateAndTime now).
	^ currentSession value
	