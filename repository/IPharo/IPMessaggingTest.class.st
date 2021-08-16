Class {
	#name : #IPMessaggingTest,
	#superclass : #TestCase,
	#instVars : [
		'session'
	],
	#category : #'IPharo-Tests'
}

{ #category : #accessing }
IPMessaggingTest >> ipMessage [
	^ IPMsg newFromWireMessage: self wireMessage 
]

{ #category : #accessing }
IPMessaggingTest >> session [
	^  IPSession getSessionForMessage: self ipMessage.
]

{ #category : #initialization }
IPMessaggingTest >> setUp [
	session := IPSession getSessionForMessage: self ipMessage.
	IPharoKernel instance start
]

{ #category : #'as yet unclassified' }
IPMessaggingTest >> shellProcessor [
	^ IPShellProcessor new.
]

{ #category : #initialization }
IPMessaggingTest >> tearDown [
	IPSession finalizeSession:'TEST'.
	IPharoKernel instance stop

]

{ #category : #tests }
IPMessaggingTest >> testExcecuteRequest [
	| sp result|
	sp := self shellProcessor.
	sp wireMessage: self wireMessage.
	result := sp execute: self wireMessage.
	self assert: (self session bindings at:#now ifAbsent:[nil]) notNil.
	self assert: ((self session bindings at:#now ) < DateAndTime now)
]

{ #category : #tests }
IPMessaggingTest >> testIPWireMessageHMAC [
	|wm|
	wm := self wireMessage.
	self assert:wm hmacIsValid 		
		

]

{ #category : #tests }
IPMessaggingTest >> testResponseHeader [
	|wm executeMessage wmResp |
	"parentHeader field in a response message must have exactly the same header than the request message
	normally we create response message instance using the session object (IPSession currentSession, it has factory methods for each kind of message
	You have to transform the message to a wireMessage before you send it back to the client"
	wm := self wireMessage.
	executeMessage := self session executeResultMessage replyingToWireMessage: wm.
	wmResp := IPWireMessage newFromMessage: executeMessage.
	self assert:wm header equals:	wmResp parentHeader	
		

]

{ #category : #accessing }
IPMessaggingTest >> wireMessage [
	"jupyter client sends:
		UUID 
		a message delimiter '<IDS|MSG>'
		'HMAC'
		'HEADER dictionary'
		'PARENT HEADER Dictionary'
		'METADATA Dictionary'
		'CONTENT Dictionary'
	we recieve one line at a time we check if there are more frames to come using.
	more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore"
	^	IPWireMessage new
		push: 'TEST';
		push: 'e1c8f884ffedef543b4a2b9f29acab51de278ffdda7e44dd927fd0c09eb674c9';
		push: '{"msg_id":"6FB84513B7DA4A9B8ACBE5656B55B115","username":"username","session":"TEST","msg_type":"execute_request","version":"5.0","date":"2018-05-04T14:31:03.597540Z"}';
		push: '{}';
		push: '{}';
		push: '{"code":"now:= DateAndTime now","silent":false,"store_history":true,"user_expressions":{},"allow_stdin":true,"stop_on_error":true}';
		yourself 
]
