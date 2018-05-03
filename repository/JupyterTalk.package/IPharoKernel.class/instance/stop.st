accessing
stop
	stop := true.
	self processors values do:[:each| each stop].
	self processors removeAll.
	IPDisplay resetCache.
	[ZmqContext terminate] on:Error do:[:e| Transcript show:e asString;cr].
	stop :=false
	 