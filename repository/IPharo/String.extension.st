Extension { #name : #String }

{ #category : #'*IPharo-Core' }
String >> asJupyterDataWithExtent: size [
	^ 'text/html'-> ('<pre>',(self asString  copyReplaceAll: String cr with: '<br/>'),'</pre>') 
]

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
