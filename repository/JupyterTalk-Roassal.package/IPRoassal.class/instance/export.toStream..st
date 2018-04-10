public-exporting
export: aView toStream: aStream

	self assert: [ aStream isStream ].

	stream := aStream.
	[
		self addStart: aView.
		self exportSVG: aView.
		self addEnd.
	] ensure: [ stream close. ].