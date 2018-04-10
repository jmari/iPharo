instance creation
new
	instance ifNotNil:[instance stop].
	instance := self basicNew.
	instance initialize.
	^ instance
	