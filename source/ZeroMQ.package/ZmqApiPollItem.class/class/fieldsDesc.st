field definition
fieldsDesc
	^#(
			ZmqApiSocket* zmqSocket;
			int filedescriptor;
			short  events;
			short  revents;
		)