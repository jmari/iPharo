as yet unclassified
evaluateTypeOfObjectInSession: session  
	| result list|
	"evaluate previous lines of code"
	[session evaluate: previousCode] on:Error do:[:e| Transcript show: e asString;cr].
	"evaluate the code to guess the object class "
	[result :=session evaluate: codeForOjectType] on:Error do:[:e| result := Object].
	objectType := result.
	list :=(result allSuperclasses 
			flatCollect:[:aClass| 
				aClass selectors]) addAll:(result selectors);yourself.
	^ {(list select:[:element|  (messagePart ,'*') match: element ] ) asSet asArray sort.
		(objectStartPos + lastSpace).
		cursorPos}.