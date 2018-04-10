initialization
initialize
	super initialize.
	ZmqContext new.
	heartbeat := ZmqRequestSocket new.
	shell := ZmqRouterSocket new. 
	control := ZmqRouterSocket new. 
	stdin := ZmqRouterSocket new. 
	ioPub := ZmqPublisherSocket new.
	stop := false.
