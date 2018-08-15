as yet unclassified
evaluateTypeOfObjectOnSession: session  
	| result list|
	
	[session evaluate: previousCode] on:Error do:[:e| Transcript show: e asString;cr].
	[result :=session evaluate: codeForOjectType] on:Error do:[:e| result := Object].
	list :=(result allSuperclasses 
			flatCollect:[:aClass| 
				aClass selectors]) addAll:(result selectors);yourself.
	^ {(list select:[:element|  (messagePart ,'*') match: element ] ) asSet asArray sort.
		(objectStartPos + lastSpace).
		cursorPos}.