as yet unclassified
traceback
	|sender traceback|
	traceback := OrderedCollection new.
	sender := self exceptionObject signalerContext sender.
	traceback add: self exceptionObject className.
	traceback add: self exceptionObject messageText asString.
	[ sender notNil ] whileTrue:[
		[traceback 
			add: sender asString.
		sender := sender sender]
		on:Error do:[sender := nil]].

	^ traceback asArray 