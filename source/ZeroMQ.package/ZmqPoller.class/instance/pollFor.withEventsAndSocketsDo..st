as yet unclassified
pollFor: aDuration withEventsAndSocketsDo: aBlockClosure
	| events eventsLeft position |
	self
		critical: [ 
			position := 0.
			events := self pollFor: aDuration.
			eventsLeft := events.
			[ eventsLeft > 0 and: [ position <= positionToSocketLookup size ] ]
				whileTrue: [ 
					| item |
					position := position + 1.
					item := self pollItemAt: position.
					item
						ifHasEvents: [ 
							eventsLeft := eventsLeft - 1.
							aBlockClosure value: item value: (self socketAt: position) ] ] ].
	^ events