comm messages
commOpenMessage
	 | msg |
	msg := IPCommOpenMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 