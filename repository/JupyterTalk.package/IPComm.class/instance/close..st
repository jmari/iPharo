instance creation
close:data
	self publish: ( IPSession currentSession commCloseMessage  new 
																					data: data;
																					commID: self uuid;
																					targetName: self targetName;
																					yourself )