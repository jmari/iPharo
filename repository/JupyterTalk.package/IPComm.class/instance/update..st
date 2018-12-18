instance creation
update: state

	self publish: (IPSession currentSession commUpdateMessage 
																		state: state;
																		commID: self uuid;
																		yourself)