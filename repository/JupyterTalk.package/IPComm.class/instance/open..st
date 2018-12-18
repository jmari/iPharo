instance creation
open: data

	self publish: (IPSession currentSession commOpenMessage 
																		data: data;
																		commID: self uuid;
																		targetName: self targetName;
																		yourself)