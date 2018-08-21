private
getCompletionListFrom: aMessage
	|session codeString  |
	
	codeString := (aMessage content at:#code). 
	cursorPos := (aMessage content at:#cursor_pos).
	session := (IPSession session: aMessage header session) veryDeepCopy.
	self parseObjectAndPartOfMessage: codeString.
	^ self evaluateTypeOfObjectInSession: session
	