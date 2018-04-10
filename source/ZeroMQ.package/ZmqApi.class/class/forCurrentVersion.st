as yet unclassified
forCurrentVersion
	(self version between: '2.0.0' and: '2.9.0')
		ifTrue: [ ^ Zmq2Api ].
	(self version between: '3.0.0' and: '3.3.0')
		ifTrue: [ ^ Zmq3Api ].
	(self version between: '4.0.0' and: '4.2.3')
		ifTrue: [ ^ Zmq4Api ].

	 ^ Zmq4Api 
	"Why is it failing when jupyter runs the kerner?"
	"self error: 'Does not know what version to use for version ' , self version asString"