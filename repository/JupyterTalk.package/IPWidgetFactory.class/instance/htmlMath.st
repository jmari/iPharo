accessing
htmlMath
	|i|
	i := IPWidget new model: IPHTMLMathModel newInstance.
	^ self openCommFor:i.