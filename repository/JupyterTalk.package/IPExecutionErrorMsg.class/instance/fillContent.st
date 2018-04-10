accessing
fillContent

	self content at:#ename put: self exceptionObject className.
	self content at:#evalue put: self exceptionObject messageText asString.
	self content at:#traceback put: self traceback.
	