shell messages
kernelInfoReplayMessage
	 | msg |
	msg := IPKernelInfoReplyMsg new. 
	msg uuid:'Ø'.
	msg header
				session: self id;
				username: self kernelUsername.
	^ msg 