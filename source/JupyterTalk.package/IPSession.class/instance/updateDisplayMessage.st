iopub messages
updateDisplayMessage
	 | msg |
	msg := IPUpdateDisplayDataMsg  new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg 