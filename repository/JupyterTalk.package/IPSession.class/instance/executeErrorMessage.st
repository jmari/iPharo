iopub messages
executeErrorMessage
	 | msg |
	msg := IPExecuteErrorMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg 