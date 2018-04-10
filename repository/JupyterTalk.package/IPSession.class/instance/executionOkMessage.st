shell messages
executionOkMessage
	 | msg |
	msg := IPExecutionOkMsg new.
	msg metadata engine: self id.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter