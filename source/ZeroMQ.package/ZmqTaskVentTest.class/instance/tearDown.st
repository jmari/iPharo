running
tearDown 

	workers do:[:w| w terminate].
	workers :=OrderedCollection new.
	self closeSockets.
	"ZmqContext terminate."