*JupyterTalk-Core
surroundedByParenthesis
	^ self class streamContents: [ :s|
		s nextPut:${.
		s nextPutAll: self.
		s nextPut:$}].