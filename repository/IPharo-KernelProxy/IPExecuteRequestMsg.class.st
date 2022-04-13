Class {
	#name : #IPExecuteRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-KernelProxy-Messages-Shell'
}

{ #category : #accessing }
IPExecuteRequestMsg >> allowStdin [
	^ self content allow_stdin
]

{ #category : #accessing }
IPExecuteRequestMsg >> allowStdin: aBool [
	self content allow_stdin: aBool
]

{ #category : #accessing }
IPExecuteRequestMsg >> code [
	^ self content code
]

{ #category : #accessing }
IPExecuteRequestMsg >> code: aString [
	self content code: aString
]

{ #category : #initialization }
IPExecuteRequestMsg >> initialize [
	super initialize.
	self msgType: #execute_request.
	self parentHeader: '{}' asByteArray .
	self metadata:{} asSCJsonObject.
	self content: {
		#silent -> false.
		#store_history -> true.
		#user_expressions->{} asSCJsonObject.
		#allow_stdin -> true.
		#stop_on_error -> false} asSCJsonObject.
]

{ #category : #accessing }
IPExecuteRequestMsg >> silent [
	^ self content silent
]

{ #category : #accessing }
IPExecuteRequestMsg >> silent: aBool [
	self content silent: aBool.
	aBool ifTrue:[ self storeHistory: false]
]

{ #category : #accessing }
IPExecuteRequestMsg >> stopOnError [
	^ self content stop_on_error
]

{ #category : #accessing }
IPExecuteRequestMsg >> stopOnError: aBool [
	self content stop_on_error: aBool
]

{ #category : #accessing }
IPExecuteRequestMsg >> storeHistory [
	^ self content store_history
]

{ #category : #accessing }
IPExecuteRequestMsg >> storeHistory: aBool [
	self content store_history: aBool
]

{ #category : #accessing }
IPExecuteRequestMsg >> userExpressions [
	^ self content userExpressions
]

{ #category : #accessing }
IPExecuteRequestMsg >> userExpressions: aDicts [
	self content userExpressions: aDicts
]
