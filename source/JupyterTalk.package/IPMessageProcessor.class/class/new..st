instance creation
new: aZmqSocket
	| i |
	i :=	self new.
	i zmqSocket: aZmqSocket.
	^ i startThread 