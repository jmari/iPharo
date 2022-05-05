Class {
	#name : #IPMsgHandlerExample,
	#superclass : #Object,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPMsgHandlerExample >> commCloseHandler: anIPMessage [
	<ipharo: #comm_close>
]

{ #category : #'as yet unclassified' }
IPMsgHandlerExample >> commMessageHandler: anIPMessage [
	<ipharo: #comm_msg>
	anIPMessage inspect
]

{ #category : #'as yet unclassified' }
IPMsgHandlerExample >> commOpenHandler: anIPMessage [
	<ipharo: #comm_open>
	anIPMessage inspect.
]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> debugEventHandler: anIPMessage [
	<ipharo: #debug_event>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> displayDataHanler: anIPMessage [
	<ipharo: #display_data>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> errorHandler: anIPMessage [
	<ipharo: #error>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> executeInputHandler: anIPMessage [
	<ipharo: #execute_input>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> executeResultHandler: anIPMessage [
	<ipharo: #execute_result>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> kernelSatatusHandler: anIPMessage [
	<ipharo: #status>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> streamHandler: anIPMessage [
	<ipharo: #stream>

	

]

{ #category : #'message-handlers' }
IPMsgHandlerExample >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>

	

]
