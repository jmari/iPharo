class membership
respondsToWireMessage: aWireMessage

	self parentHeader: aWireMessage header.
	self uuid: aWireMessage uuid.