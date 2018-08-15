tests
testAutocomplete:code pos: pos
	| aMessage completer list |
	aMessage := IPMsg new.
	completer := IPCompleter new.
	aMessage content at:#code put: code.
	aMessage content at:#cursor_pos put: pos.
	aMessage header session:'TEST'.
	list := completer getCompletionListFrom: aMessage.
	
	^ list
	