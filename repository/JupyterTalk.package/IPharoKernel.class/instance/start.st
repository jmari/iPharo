accessing
start
 	self processors at:#shell put: (IPShellProcessor new: shell).
	self processors at:#ctrl put: (IPControlProcessor new:control).
	self processors at:#stdin put: (IPStdInProcessor new:stdin).
	self processors at:#iopub put: (IPIOPubProcessor new:ioPub).
	self heartbeatThread.
	IPSession finalizeSession
