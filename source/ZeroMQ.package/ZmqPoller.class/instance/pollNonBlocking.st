as yet unclassified
pollNonBlocking
	| events |
	self
		critical: [ 
			events := self context zmqApi
				executeApiCall: [ self context zmqApi apiZmqPollSockets: pollItemStructure ofLenght: positionToSocketLookup size withTimeout: 0 ].
			events < 0
				ifTrue: [ self logError: 'Poller encountered error: ' , self zmqApi lastZmqError ].		
			^ events ]