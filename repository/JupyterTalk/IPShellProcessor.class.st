Class {
	#name : #IPShellProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'completer'
	],
	#category : 'JupyterTalk-Core'
}

{ #category : #accessing }
IPShellProcessor >> completer [
	^ completer ifNil:[completer := IPVSAutoCompleter new]
]

{ #category : #running }
IPShellProcessor >> execute: aWireMessage [
	| message response|

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg new respondsToWireMessage: aWireMessage).
	message msgType = #kernel_info_request ifTrue:[ response:=self executeKernelInfoRequest: message].	
	message msgType = #comm_info_request ifTrue:[ response:=self executeCommInfoRequest: message].			
	message msgType = #execute_request ifTrue:[ response:=self executeExecuteRequest: message].
	message msgType = #is_complete_request ifTrue:[ response:=self executeIsCompleteRequest: message].
	message msgType = #shutdown_request ifTrue:[ self executeShutdown: message].
	message msgType = #complete_request ifTrue:[ response:=self executeCompleteRequest: message].
	"Comm messaging protocol, handlers are implemented in super because iopub also use them"
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	
	message msgType = #update_state ifTrue:[ self executeUpdateState: message].	
	message msgType = #request_state ifTrue:[ self executeUpdateState: message].	
	response ifNotNil:[self respond: response].
	self publish:  (IPKernelStatusIdleMsg new respondsToWireMessage: aWireMessage).

	
]

{ #category : #running }
IPShellProcessor >> executeCommInfoRequest: aMessage [
	| response |
	response := IPCommInfoReplyMsg new.
	"parent_header must be exactly the same header"
	response respondsToWireMessage: self wireMessage.
	^  response
	
]

{ #category : #private }
IPShellProcessor >> executeCompleteRequest: aMessage [
	| response completionList |

	response := IPCompleteReplyMsg new.
	completionList := self completer getCompletionListFrom: aMessage.
	response content matches: (completionList at:1).
	response content at:#cursor_start put: (completionList at:2).
	response content at:#cursor_end put: (completionList at:3).
	response content at:#status put:#ok. 
	"parent_header must be exactly the same header"
	response respondsToWireMessage: self wireMessage.
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeExecuteRequest: aMessage [
	| response session  |
	"parent_header must be exactly the same header"

	[session := IPSession session: aMessage header session]
	on: Error do:[session := IPSession newSessionFor: aMessage header].
	session ifNil:[ session := IPSession newSessionFor: aMessage header].
	
	self publish: (session executeInputMessage
										respondsToWireMessage: self wireMessage;
										code:aMessage content code;
										yourself ).	
	[[session compileAndEvaluate: aMessage] 
		on:OCUndeclaredVariableWarning do:["Nothing"]]
		on:Exception do:[:e| 
			response := (session executionErrorMessage 
									respondsToWireMessage: self wireMessage;
									exceptionObject: e;
									yourself).
			self publish: (session executeErrorMessage    
									content: response content;
									respondsToWireMessage: self wireMessage;
									yourself)].
	response ifNil:[
		response:= session executionOkMessage.
		response respondsToWireMessage: self wireMessage ].

	session increaseExecutionCounter.	
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeIsCompleteRequest: aMessage [
	| response |
	response := IPIsCompleteReplyMsg new.
	"parent_header must be exactly the same header"
	response respondsToWireMessage: self wireMessage.
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeKernelInfoRequest: aMessage [
	| response session|
	
	session := IPSession newSessionFor: aMessage header.
	response := session kernelInfoReplayMessage.
	"must be exactly the same header"
	response respondsToWireMessage: self wireMessage.

	^  response
	
]

{ #category : #running }
IPShellProcessor >> executeShutdown: aMessage [
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #accessing }
IPShellProcessor >> threadName [
	^ 'ipharo-shell' 
]
