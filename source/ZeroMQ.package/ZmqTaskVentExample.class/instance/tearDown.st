initialization
tearDown 

	workers do:[:w| w terminate].
	self closeSockets.
	"ZmqContext terminate."