as yet unclassified
positionOfSocket: aZmqSocket
	^ self positionOfSocket: aZmqSocket ifAbsent: [ Error signal: 'Unkown socket' ]