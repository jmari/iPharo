Class {
	#name : #IPInspectRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPInspectRequestMsg >> code: codeString cursorPos: anInteger [
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
IPInspectRequestMsg >> initialize [
	super initialize.
	self msgType: #inspect_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content:     {
	"# The code context in which introspection is requested
    # this may be up to an entire multiline cell."
    'code' -> ''.
   " # The cursor position within 'code' (in unicode characters) where inspection is requested"
    'cursor_pos' -> 1.
   " # The level of detail desired.  In IPython, the default (0) is equivalent to typing
    # 'x?' at the prompt, 1 is equivalent to 'x??'.
    # The difference is up to kernels, but in IPython level 1 includes the source code
    # if available."
    'detail_level' ->0} asSCJsonObject 

]
