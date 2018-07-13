comm handlers
send: data
	self publish: (IPSession currentSession commMsgMessage 
																commID: self uuid;
																data:data;
																targetName: self targetName;
																yourself)