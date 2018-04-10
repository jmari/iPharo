accessing
roassalJSfile
	^ roassalJSfile ifNil: [ roassalJSfile := self defaultRoassalJSfile ]