threads
heartbeatThread
	[	|echoData|
	[
		[ self isStopping ] whileFalse:[
			echoData := heartbeat receiveAndWait. 
			heartbeat send: echoData asByteArray]
	]on:Error do:[:e| self debug:e]
	] forkNamed:'ipharo-echo' 