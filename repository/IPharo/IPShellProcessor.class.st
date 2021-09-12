Class {
	#name : #IPShellProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'completer'
	],
	#category : #'IPharo-Core'
}

{ #category : #accessing }
IPShellProcessor >> completion [
	^ completer ifNil:[completer := IPCompletion new]
]

{ #category : #running }
IPShellProcessor >> execute: aWireMessage [
	| message session|

	message := IPMsg newFromWireMessage: aWireMessage.
	session := IPSession getSessionForMessage: message.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.
]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeCommCloseRequest: aMessage [
	<ipharo: #comm_close>
	
	IPharoKernel instance commManager unregisterComm: (aMessage content at:#comm_id).
	"NO-RESPONSE"
]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeCommInfoRequest: aMessage [
	<ipharo:#comm_info_request>
	
	| response session |
	session := IPSession getSessionForMessage: aMessage.
	response := session commInfoReplyMessage.
	self sendMessage: response
	
]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeCommMsgRequest: aMessage [ 
	<ipharo:#comm_msg> 
	
	| comm data |
	
	comm :=(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)). 
	data := aMessage content at:#data.
	(data at:#method) = 'update' ifTrue:[ comm commListeners do:[:l| l updateState:(data at:#state)]].
	(data at:#method) = 'request_state' ifTrue:[ comm commListeners 
		do:[:l| comm update:l model state]].	 

]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeCommOpenRequest: aMessage [
	<ipharo: #comm_open>
	
	IPComm new:(aMessage content at:#comm_id) onSession: (IPSession getSessionForMessage: aMessage)

	"NO-RESPONSE"

	
	

]

{ #category : #private }
IPShellProcessor >> executeCompleteRequest: aMessage [
	<ipharo: #complete_request>
	
	| response completionList session |
		
	session := IPSession getSessionForMessage: aMessage.
	response := session completeReplyMsg.
	completionList := self completion getCompletionListFrom: aMessage.
	response content matches: (completionList at:1).
	response content at:#cursor_start put: (completionList at:2).
	response content at:#cursor_end put: (completionList at:3).
	response content at:#status put:#ok. 

	self sendMessage: response
]

{ #category : #'message-handling' }
IPShellProcessor >> executeExecuteRequest: aMessage [
	<ipharo: #execute_request>
	
	| response session  |

	session := IPSession getSessionForMessage: aMessage.
	self publish: (session executeInputMessage	code:aMessage content code).	
	[ session compileAndEvaluate: aMessage.  
	  self sendMessage: session executionOkMessage.
	  session increaseExecutionCounter] 
	on: Exception do:[ :e | 
			response := (session executionErrorMessage 	exceptionObject: e).
			self publish: (session executeErrorMessage content: response content).
			self sendMessage: response ]
]

{ #category : #'message-handling' }
IPShellProcessor >> executeIsCompleteRequest: aMessage [
	<ipharo: #is_complete_request>
	
	| response |

	response := IPIsCompleteReplyMsg newReplyingToWireMessage: self wireMessage.
	self sendMessage: response
	
]

{ #category : #'message-handling' }
IPShellProcessor >> executeKernelInfoRequest: aMessage [
	<ipharo: #kernel_info_request>
	
	| session|

	session := IPSession getSessionForMessage: aMessage.
	self sendMessage: session kernelInfoReplayMessage
]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeRequestState: aMessage [ 
	<ipharo: #request_state>
	
	(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)) 
	commListeners do:[:aMsgHandler|
		aMsgHandler comm update: aMsgHandler model state].
]

{ #category : #'message-handling-comm' }
IPShellProcessor >> executeUpdateState: aMessage [ 
   <ipharo:#update_state>

	| response | 
	       
	(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)) commListeners  
	 do:[ :aListener | response := aListener model state: (aMessage content at:#state) ]
]

{ #category : #accessing }
IPShellProcessor >> threadName [
	^ 'ipharo-shell' 
]
