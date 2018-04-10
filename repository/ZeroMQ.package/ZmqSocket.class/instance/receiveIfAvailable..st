queries
receiveIfAvailable: anOneArgumentBlock
	| data |
	data := self receiveIfAvailable.
	^ data ifNotNil: anOneArgumentBlock