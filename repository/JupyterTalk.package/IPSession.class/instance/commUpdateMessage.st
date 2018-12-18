comm messages
commUpdateMessage
	 | msg |
	msg := IPCommUpdateMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 