instance creation
new
	|instance|
	instance := super new.
	IPharoKernel instance commManager registerComm: instance.
	^ instance 
	