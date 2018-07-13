comm handlers
publish: aResult
	aResult respondsToWireMessage:(IPharoKernel instance processors at:#shell) wireMessage.
	(IPharoKernel instance processors at:#iopub) publish:  aResult