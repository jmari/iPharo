system startup
shutDown
	self instance stop.
	instance:=nil.
	(Delay forSeconds:1) wait