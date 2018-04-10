private-api conveniency
executeApiCall: aBlock
	| retVal tryAgains |
	retVal := aBlock value.
	tryAgains := {(ZmqApiConstants errnoEAGAIN).
	(ZmqApiConstants errnoEINTR)}.
	retVal < 0
		ifTrue: [ 
			| errno |
			errno := self apiZmqErrno.
			(tryAgains includes: errno)
				ifFalse: [ 
					self signalErrno: errno. ] ].
	^ retVal