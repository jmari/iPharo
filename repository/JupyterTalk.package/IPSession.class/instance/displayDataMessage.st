iopub messages
displayDataMessage
	 | msg |
	msg := IPDisplayDataMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 