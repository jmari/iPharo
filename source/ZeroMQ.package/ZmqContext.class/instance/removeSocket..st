private
removeSocket: aZmqSocket
	resources remove: aZmqSocket.
	self removeFromPoller: aZmqSocket.
	aZmqSocket privateClose