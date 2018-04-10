public-api
refresh: anUUID 
	| cdata udm|
	self resetJupyterData.
	cdata:= self cachedObjects at:anUUID ifAbsent:[self error:'Object ', anUUID asString,' not found'].
	"get the old object and execute display again"
	cdata at:#interactive 
		ifPresent:[self displayInteractive: (cdata at:#data) extent:(cdata at:#extent ifAbsent:[nil])]
		ifAbsent: [self display: (cdata at:#data) extent:(cdata at:#extent ifAbsent:[nil])].
	udm := self updateDisplayMessage.
	udm content addAll: self jupyterData .	
	udm transient: {#display_id -> anUUID} asSCJsonObject.
	udm metadata: (cdata at:#metadata).
	udm respondsToWireMessage:(IPharoKernel instance processors at:#shell) wireMessage.
	self publish:udm.
	self resetJupyterData.	
	
	