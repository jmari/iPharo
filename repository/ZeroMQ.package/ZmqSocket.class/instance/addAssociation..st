as yet unclassified
addAssociation: aZmqSocketAssociation
	monitor
		critical: [ 
			aZmqSocketAssociation associateSocket: self.
			associations add: aZmqSocketAssociation ]