Extension { #name : #String }

{ #category : #'*JupyterTalk-Core' }
String >> surroundedByParenthesis [
	^ self class streamContents: [ :s|
		s nextPut:${.
		s nextPutAll: self.
		s nextPut:$}].
]

{ #category : #'*JupyterTalk-Core' }
String >> surroundedBySingleQuotes [
	"Answer the receiver with leading and trailing quotes.  "

	^ self surroundedBy: ($' asString)
]
