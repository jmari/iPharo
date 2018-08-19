parsing
parseObjectAndPartOfMessage: codeString 
	| balanced trail interestingCode followLoop |
	
	objectStartPos := cursorPos.	
	balanced := 0.	
	trail := String new.
	followLoop := true.
	[ objectStartPos>0 and:[(self stopChars includes: (codeString at:objectStartPos)) not and:[followLoop] ]] whileTrue:[
		(codeString at:objectStartPos) =$( ifTrue:[ 
												balanced := balanced -1.
												trail := trail , ')'].
		(codeString at:objectStartPos) =$) ifTrue:[balanced := balanced +1].
		objectStartPos := objectStartPos - 1.
		followLoop := (objectStartPos >=1 and:[(codeString at:objectStartPos) =$: and:[balanced <= 0]]) not.
		].
	interestingCode := (codeString copyFrom:objectStartPos + 1 to: cursorPos).
	
	
	lastSpace := interestingCode findLastOccurrenceOfString: ' ' startingAt: 1.
	lastSpace >0 
		ifTrue:[
			objectPart := (interestingCode copyFrom: 1 to: lastSpace). 
			balanced <0 ifTrue:[ objectPart := objectPart , trail].
			messagePart  := (interestingCode copyFrom: lastSpace to: interestingCode size) trimBoth.
		] ifFalse:[
			objectPart := interestingCode.
			messagePart  := ''].
	previousCodePos := objectStartPos.

	[ previousCodePos>1 and:[ ($.= (codeString at:previousCodePos)) not ]] whileTrue:[previousCodePos := previousCodePos - 1].
	previousCode := codeString copyFrom:1 to: previousCodePos.
	codeForOjectType  :=  self guessObjectCode: objectPart
	
