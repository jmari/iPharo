comm messages
commMsgMessage
	 | msg |
	msg := IPCommMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 