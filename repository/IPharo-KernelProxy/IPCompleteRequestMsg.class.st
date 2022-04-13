Class {
	#name : #IPCompleteRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-KernelProxy-Messages-Shell'
}

{ #category : #initialization }
IPCompleteRequestMsg >> code: codeString cursorPos: anInteger [
"	 # The code context in which completion is requested
    # this may be up to an entire multiline cell, such as
    # 'foo = a.isal'
    'code' : str,
    # The cursor position within 'code' (in unicode characters) where completion is requested
    'cursor_pos' : int,"
	self content code: codeString.
	self content cursor_pos: anInteger
]

{ #category : #initialization }
IPCompleteRequestMsg >> initialize [
	super initialize.
	self msgType: #complete_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new.

]
