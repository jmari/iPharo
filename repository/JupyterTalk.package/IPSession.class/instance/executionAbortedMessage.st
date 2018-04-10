shell messages
executionAbortedMessage
	 | msg |
	msg := IPExecutionAbortedMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter