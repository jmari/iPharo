Class {
	#name : #IPInspectReplyMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPInspectReplyMsg >> initialize [
	super initialize.
	self msgType: #inspect_replay.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {
   " # 'ok' if the request succeeded or 'error', with error information as in all other replies."
    'status' -> 'ok'.
    "# found should be true if an object was found, false otherwise"
    'found' -> false.
    "# data can be empty if nothing is found"
    'data' -> SCJsonObject new.
    'metadata' -> SCJsonObject new.
	} asSCJsonObject 
	

]
