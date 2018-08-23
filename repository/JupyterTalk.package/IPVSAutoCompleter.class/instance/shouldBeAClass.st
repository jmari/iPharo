private
shouldBeAClass 

	^ (messagePart = '' and:[(objectPart endsWith: ' ') not]) 
	or:[objectPart trimBoth  = '' and:[messagePart ~= ''] ]