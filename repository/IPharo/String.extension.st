Extension { #name : #String }

{ #category : #'*IPharo-Core' }
String >> surroundedByParenthesis [
	^ self class streamContents: [ :s|
		s nextPut:${.
		s nextPutAll: self.
		s nextPut:$}].
]

{ #category : #'*IPharo-Core' }
String >> surroundedBySingleQuotes [
	"Answer the receiver with leading and trailing quotes.  "

	^ self surroundedBy: ($' asString)
]
