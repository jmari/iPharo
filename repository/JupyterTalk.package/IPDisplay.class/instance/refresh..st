public-api
refresh: anUUID 
	| cdata udm|

	cdata:= self class cachedObjects at:anUUID ifAbsent:[self error:'Object ', anUUID asString,' not found in jupyter kernel cache'].
	"get the old object and execute display again"
	cdata at:#interactive ifPresent:[self interactionOn].
	self openInJupyter: (cdata at:#data) extent: (cdata at:#extent). 
	udm := IPSession currentSession  updateDisplayMessage.
	udm content addAll: self jupyterData .	
	udm transient: {#display_id -> anUUID} asSCJsonObject.
	udm metadata: (cdata at:#metadata).
	udm respondsToWireMessage:(IPharoKernel instance processors at:#shell) wireMessage.
	self publish:udm.
	