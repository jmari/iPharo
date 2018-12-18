accessing
stop
	stop := true.
	self processors values do:[:each| each stop].
	self processors removeAll.
	self commManager commChannels removeAll.
	IPDisplay resetCache.
	[ZmqContext terminate] on:Error do:[:e|].
	stop :=false
	 