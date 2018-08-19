private
getCompletionListFrom: aMessage
	|session codeString  |
	
	codeString := (aMessage content at:#code). 
	cursorPos := (aMessage content at:#cursor_pos).
	self parseObjectAndPartOfMessage: codeString.
	session := (IPSession session: aMessage header session) veryDeepCopy.

	^ self evaluateTypeOfObjectInSession: session
	