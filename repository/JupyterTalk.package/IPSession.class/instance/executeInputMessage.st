iopub messages
executeInputMessage
	 | msg |
	msg := IPExecuteInputMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  executionCounter
	
																						