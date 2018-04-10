as yet unclassified
pollItemAt: anInteger
	" Creates struct for poll item at given position. Positions start from 1."

	^ ZmqApiPollItem fromHandle: pollItemExternalAddress + ((anInteger - 1) * ZmqApiPollItem byteSize).