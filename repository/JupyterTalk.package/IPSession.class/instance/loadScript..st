public-api
loadScript: aStringScript

	self jupyterData data at:'text/html' put:aStringScript.
	self jupyterData metadata: SCJsonObject new.

	
	 
	
														
														