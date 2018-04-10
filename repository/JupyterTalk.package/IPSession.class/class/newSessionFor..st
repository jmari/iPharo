instance creation
newSessionFor: aHeader

	^ self sessions 
			at: aHeader session
			put:(self new 
							username: aHeader username;
							id: aHeader session;
							startTime: aHeader timestamp).
		
									