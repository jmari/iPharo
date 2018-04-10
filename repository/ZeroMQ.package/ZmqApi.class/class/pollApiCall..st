private-api conveniency
pollApiCall: aBlock
	"Polls non blocking Api call until it returns a result."

	| retVal |
	[ 
	retVal := self executeApiCall: aBlock.
	retVal < 0 ] whileTrue: [ Processor yield ].
	^ retVal