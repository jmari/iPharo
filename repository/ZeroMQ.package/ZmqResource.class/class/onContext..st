as yet unclassified
onContext: aZmqContext
	|instance|
	instance := self basicNew.
	instance context: aZmqContext.
	instance initialize.
	
	^ instance