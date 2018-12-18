as yet unclassified
commID
	^ self content at:#comm_id ifAbsentPut:[ self msgUUID ]