Class {
	#name : #IPShellProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'completer'
	],
	#category : #'IPharo-Core'
}

{ #category : #accessing }
IPShellProcessor >> completer [
	^ completer ifNil:[completer := IPVSAutoCompleter new]
]

{ #category : #running }
IPShellProcessor >> execute: aWireMessage [
	| message response|

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg newReplyingToWireMessage: aWireMessage).
	message msgType = #kernel_info_request ifTrue:[ response:=self executeKernelInfoRequest: message ].	
	message msgType = #comm_info_request ifTrue:[ response:=self executeCommInfoRequest: message ].			
	message msgType = #execute_request ifTrue:[ response:=self executeExecuteRequest: message ].
	message msgType = #is_complete_request ifTrue:[ response:=self executeIsCompleteRequest: message ].
	message msgType = #shutdown_request ifTrue:[ self executeShutdown: message ].
	message msgType = #complete_request ifTrue:[ response:=self executeCompleteRequest: message ].
	"Comm messaging protocol, handlers are implemented in super because iopub also use them"
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message ].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	
	message msgType = #update_state ifTrue:[ self executeUpdateState: message].	
	message msgType = #request_state ifTrue:[ self executeUpdateState: message].	
	response ifNotNil:[self respond: response].
	self publish:  (IPKernelStatusIdleMsg newReplyingToWireMessage: aWireMessage).
]

{ #category : #running }
IPShellProcessor >> executeCommInfoRequest: aMessage [
	| response |
	response := IPCommInfoReplyMsg new.
	"parent_header must be exactly the same header"
	response replyingToWireMessage: self wireMessage.
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
	response replyingToWireMessage: self wireMessage.
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeExecuteRequest: aMessage [
	| response session  |
	"parent_header must be exactly the same header"

	session := IPSession getSessionForMessage: aMessage.
self halt.
	self publish: (session executeInputMessage	code:aMessage content code).	
	[session compileAndEvaluate: aMessage]
		on:Exception do:[:e| 
			response := (session executionErrorMessage 	exceptionObject: e).
			self publish: (session executeErrorMessage content: response content) ].
	response ifNil:[response:= session executionOkMessage ].

	session increaseExecutionCounter.	
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeIsCompleteRequest: aMessage [
	| response |
	response := IPIsCompleteReplyMsg new.
	"parent_header must be exactly the same header"
	response replyingToWireMessage: self wireMessage.
	^ response
	
]

{ #category : #running }
IPShellProcessor >> executeKernelInfoRequest: aMessage [
	| session|
	
	session := IPSession getSessionForMessage: aMessage.
	^ session kernelInfoReplayMessage.


	
]

{ #category : #running }
IPShellProcessor >> executeShutdown: aMessage [
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #accessing }
IPShellProcessor >> threadName [
	^ 'ipharo-shell' 
]
