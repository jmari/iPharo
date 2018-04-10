as yet unclassified
removeSocket: aZmqSocket
	| sockets |
	self
		critical: [ 
			| oldSockets |
			oldSockets := socketToPositionLookup keys.
			sockets := oldSockets copyWithout: aZmqSocket.
			self logDebug: 'Before removal ', oldSockets size asString, ' after removal ', sockets size asString,'.'.
			self initializeLookups.
			sockets asArray
				keysAndValuesDo: [ :i :v | 
					socketToPositionLookup at: v put: i.
					positionToSocketLookup at: i put: v.
					 ].
				self rebuildPollItemStructure.
				 ]