shell messages
executionErrorMessage
	 | msg |
	msg := IPExecutionErrorMsg new. 
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter