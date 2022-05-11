"
I'm a message processor for the Shell channel, I process messages comming from the shell socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.
Almost all of the messages are processed by me, specially remark to the execute request, Comm messaging (for widgets), complete, inspect... 
"
Class {
	#name : #IPShellRouterProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'completer',
		'currentEvaluatedProcess'
	],
	#category : #'IPharo-Core'
}

{ #category : #accessing }
IPShellRouterProcessor >> completion [
	^ completer ifNil:[completer := IPCompletion new]
]

{ #category : #running }
IPShellRouterProcessor >> execute: aWireMessage [
	| message session|

	message := IPMsg newFromWireMessage: aWireMessage.
	session := message session.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.
]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeCommCloseRequest: aMessage [
	<ipharo: #comm_close>
	| data comm |
	comm :=(aMessage session commManager commChannelAt:(aMessage content at:#comm_id)). 
	data := aMessage content at:#data.
	comm data: data.
	aMessage session commManager unregisterComm: (aMessage content at:#comm_id).
	"NO-RESPONSE"
]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeCommInfoRequest: aMessage [
	<ipharo:#comm_info_request>
	
	self sendMessage: aMessage session commInfoReplyMessage.
	
]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeCommMsgRequest: aMessage [ 
	<ipharo:#comm_msg> 
	
	| comm data |
	comm :=(aMessage session commManager commChannelAt:(aMessage content at:#comm_id)). 
	data := aMessage content at:#data.
	comm data: data.
 	comm commListeners do:[:l| l onDataReceived: data ].
	"NO-RESPONSE-ON-SHELL"

]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeCommOpenRequest: aMessage [
	<ipharo: #comm_open>
	| instance |
	instance := IPComm new:(aMessage content at:#comm_id) onSession: aMessage session.
	instance targetName: (aMessage content at:#target_name).
	instance data: (aMessage content at:#data).
	"NO-RESPONSE"

	
	

]

{ #category : #private }
IPShellRouterProcessor >> executeCompleteRequest: aMessage [
	<ipharo: #complete_request>
	
	| response completionList session |
		
	session := aMessage session.
	response := session completeReplyMsg.
	completionList := self completion getCompletionListFrom: aMessage.
	response content matches: (completionList at:1).
	response content at:#cursor_start put: (completionList at:2).
	response content at:#cursor_end put: (completionList at:3).
	response content at:#status put:#ok. 

	self sendMessage: response
]

{ #category : #'message-handling' }
IPShellRouterProcessor >> executeExecuteRequest: aMessage [
	<ipharo: #execute_request>
	
	| response session  |

	session :=  aMessage session.
	self publish: (session executeInputMessage	code:aMessage content code).	
	[ 
	currentEvaluatedProcess := [session compileAndEvaluate: aMessage.  
	  self sendMessage: session executionOkMessage.
	  session increaseExecutionCounter] forkAndWait .
	
	] on: Exception do:[ :e | 
			response := (session executionErrorMessage 	exceptionObject: e).
			self publish: (session executeErrorMessage content: response content).
			self sendMessage: response ]
]

{ #category : #'message-handling' }
IPShellRouterProcessor >> executeHistoryRequest: aMessage [
	<ipharo: #history_request>
	
	| session historyMsg result from to pattern |

	session := aMessage session.
	historyMsg := session historyReplayMessage.
	result :={}.
	aMessage content hist_access_type = #tail ifTrue:[
		from := session history size - aMessage content n.
		from := from > 0 ifTrue:[from] ifFalse:[ 1 ].
		to := session history size.
		result := session history copyFrom:from to:to ].
	
	aMessage content hist_access_type = #range ifTrue:[
		from := aMessage content start.
		to := aMessage content stop.
		result := session history copyFrom:from to:to  ].
	
	aMessage content hist_access_type = #search ifTrue:[
		pattern := aMessage content pattern.
		result := (self history select:[ :h | pattern matches: h last first ])
						collect:[ :h | 
							aMessage content output = true
							ifTrue:[ h ]
							ifFalse: [ { h first. h second. h last first } ] ] ].
	historyMsg content history: result asArray.
	self flag:#todo " pending. include duplicated history.  Default is false, but doesn't seems useful".
	self sendMessage: historyMsg
]

{ #category : #'message-handling' }
IPShellRouterProcessor >> executeInspectRequest: aMessage [
	<ipharo: #inspect_request>
	
	| session inspectReplyMsg code|

	session := aMessage session.
	inspectReplyMsg := session inspectReplyMessage.
	code := self inspectablePart: aMessage content code pos: aMessage content cursor_pos.
	[ inspectReplyMsg content 
			data: (session eval: code) asSCJsonObject;
			found:true.
	  ] on:Exception do:[ 
		inspectReplyMsg content status: 'error' ].
	self sendMessage: inspectReplyMsg
	
]

{ #category : #'message-handling' }
IPShellRouterProcessor >> executeIsCompleteRequest: aMessage [
	<ipharo: #is_complete_request>
	
	| session isCompleteReplyMsg |
	
	session := aMessage session.
	isCompleteReplyMsg := session isCompleteReplayMessage.
	[ self class compiler source: aMessage content code;parseExpression  ] on:Exception do:[ :e| e inspect.isCompleteReplyMsg content status: 'invalid' ].
	self sendMessage: isCompleteReplyMsg
	
]

{ #category : #'message-handling' }
IPShellRouterProcessor >> executeKernelInfoRequest: aMessage [
	<ipharo: #kernel_info_request>
	
	| session|

	session := aMessage session.
	self sendMessage: session kernelInfoReplayMessage
]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeRequestState: aMessage [ 
	<ipharo: #request_state>
	
	(aMessage session commManager commChannelAt:(aMessage content at:#comm_id)) 
	commListeners do:[:aMsgHandler|
		aMsgHandler comm update: aMsgHandler model state].
	"NO-RESPONSE-ON-SHELL"
]

{ #category : #'message-handling-comm' }
IPShellRouterProcessor >> executeUpdateState: aMessage [ 
   <ipharo:#update_state>

	| response | 
	       
	(aMessage session commManager commChannelAt:(aMessage content at:#comm_id)) commListeners  
	 do:[ :aListener | response := aListener model state: (aMessage content at:#state) ]
]

{ #category : #utils }
IPShellRouterProcessor >> inspectablePart: aStringWithSourCode pos: cursorPos [
	| stopBackCharacters stopForwardCharacters pos start end |
	stopBackCharacters := { $=. $[. $(. ${. $.. $|. }.
	stopForwardCharacters := { $.. Character space }.
	pos := cursorPos.
	start := 1.
	[ pos > 0 and:[ start = 1 ] ] whileTrue:[ 
		(stopBackCharacters includes: (aStringWithSourCode at: pos )) ifTrue:[ start := pos].
		pos := pos - 1 ].
	pos := cursorPos.
	end := aStringWithSourCode size.
	[ pos > 0 and:[ end = aStringWithSourCode size ]] whileTrue:[ 
		(stopForwardCharacters includes: (aStringWithSourCode at: pos )) ifTrue:[ end := pos].
		pos := pos + 1 ].
	^ aStringWithSourCode copyFrom: start to: end 
]

{ #category : #utils }
IPShellRouterProcessor >> interrupt [ 
	"interrupt the evaluation in an executionRequest"
	currentEvaluatedProcess ifNotNil:
	[ currentEvaluatedProcess isTerminated ifFalse:[ currentEvaluatedProcess terminate ] ]
]

{ #category : #accessing }
IPShellRouterProcessor >> threadName [
	^ 'ipharo-shell' 
]
