synchronization
critical: aBlock
	^ monitor
		critical: [ 
			parked
				ifTrue: [ monitor wait ].
			aBlock value ]