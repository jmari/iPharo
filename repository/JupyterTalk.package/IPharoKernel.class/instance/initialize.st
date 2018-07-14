initialization
initialize
	super initialize.
	ZmqContext current.
	heartbeat := ZmqRequestSocket new.
	shell := ZmqRouterSocket new. 
	control := ZmqRouterSocket new. 
	stdin := ZmqRouterSocket new. 
	ioPub := ZmqPublisherSocket new.
	stop := false.
