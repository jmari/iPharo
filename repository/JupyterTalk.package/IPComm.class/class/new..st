instance creation
new: anUUID
	|instance|
	instance := super new.
	instance uuid: anUUID.
	IPharoKernel instance commManager registerComm: instance.
	^ instance 
	