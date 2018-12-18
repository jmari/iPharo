instance creation
new
	| i |
	i := super new.
	i comm: IPComm new.
	i comm addCommListener: i.
	^ i