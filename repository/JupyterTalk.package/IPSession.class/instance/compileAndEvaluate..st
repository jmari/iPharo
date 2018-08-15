compilation
compileAndEvaluate: aMessage
	| result |
	result := self evaluate: aMessage content code.
	self hasJupyterData  ifFalse:[self display openInJupyter: result asString].
	^ self jupyterData.
	