as yet unclassified
injectScript: aStringScript
	self jupyterData data at:'text/html' put:aStringScript.
	self jupyterData metadata: SCJsonObject new.
	self composeResponse: self jupyterData. 
	self reset.
	