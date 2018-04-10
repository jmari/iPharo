instance creation
new
	"There is only on thread in Squeak VM so there can only be one context."

	^ instance
		ifNil: [ instance := super new ]
		ifNotNil: [ 
			instance isTerminated
				ifTrue: [ 
					instance := nil.
					self new ]
				ifFalse: [ instance ] ]