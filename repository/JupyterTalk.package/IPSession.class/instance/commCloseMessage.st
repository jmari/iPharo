comm messages
commCloseMessage
	 | msg |
	msg := IPCommCloseMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 