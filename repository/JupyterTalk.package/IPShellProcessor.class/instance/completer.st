accessing
completer
	^ completer ifNil:[completer := IPVSAutoCompleter new]