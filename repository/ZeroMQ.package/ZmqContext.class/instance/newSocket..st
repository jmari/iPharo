private
newSocket: aSocketClass
	| socket |
	socket := aSocketClass context: self.
	self register: socket.
	^ socket