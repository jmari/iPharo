as yet unclassified
toVersion: aZmqVersionOrString
	^ aZmqVersionOrString isString
		ifTrue: [ self fromString: aZmqVersionOrString ]
		ifFalse: [ aZmqVersionOrString ]