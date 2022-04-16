Class {
	#name : #IPHistoryReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPHistoryReplyMsg >> initialize [
	super initialize.
	self msgType: #history_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: { 
						#status -> 'ok'.
						"'ok' if the request succeeded or 'error', with error information as in all other replies.
  						'status' : 'ok',
  						# A list of 3 tuples, either:
  						# (session, line_number, input) or
  						# (session, line_number, (input, output)),
  						# depending on whether output was False or True, respectively."
						#history -> {}  
						} asSCJsonObject 
]
