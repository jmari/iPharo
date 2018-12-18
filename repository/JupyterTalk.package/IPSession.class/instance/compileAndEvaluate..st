compilation
compileAndEvaluate: aMessage
	| result |
	self display reset.
	result := self evaluate: aMessage content code.
	self display hasJupyterData 
								ifFalse:[self display openInJupyter: result asString].
	
	