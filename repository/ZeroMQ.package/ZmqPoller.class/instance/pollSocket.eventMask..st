as yet unclassified
pollSocket: aZmqSocket eventMask: events
	| position newPollItemStructure item |
	self
		critical: [ 
			position := self
				positionOfSocket: aZmqSocket
				ifAbsent: [ socketToPositionLookup at: aZmqSocket put: socketToPositionLookup size + 1 ].
			positionToSocketLookup at: position put: aZmqSocket.
			newPollItemStructure := ExternalAddress allocate: ZmqApiPollItem byteSize * positionToSocketLookup size.
			pollItemExternalAddress
				ifNotNil: [ 
					newPollItemStructure
						structAt: 1
						put: pollItemExternalAddress
						length: ZmqApiPollItem byteSize * (positionToSocketLookup size - 1).
					pollItemExternalAddress free ].
			pollItemExternalAddress := newPollItemStructure.
			item := self pollItemAt: position.
			item zmqSocket: aZmqSocket socketPointer.
			item events: events.
			item filedescriptor: 0.
			pollItemStructure := FFIExternalStructure fromHandle: pollItemExternalAddress.
			^ position ]