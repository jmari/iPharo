accessing
stop
	stop := true.
	self processors values do:[:each| each stop].
	self processors removeAll.
	[ZmqContext terminate] on:Error do:[:e| Transcript show:e asString;cr].
	stop :=false
	 