as yet unclassified
finalize
	pollItemExternalAddress ifNotNil:[pollItemExternalAddress free].
	super finalize.