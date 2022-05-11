Class {
	#name : #IPIOTestMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #'as yet unclassified' }
IPIOTestMsgHandler >> commCloseHandler: anIPMessage [
	<ipharo: #comm_close>
	anIPMessage inspect
]

{ #category : #'as yet unclassified' }
IPIOTestMsgHandler >> commMessageHandler: anIPMessage [
	<ipharo: #comm_msg>
	anIPMessage inspect
]

{ #category : #'as yet unclassified' }
IPIOTestMsgHandler >> commOpenHandler: anIPMessage [
	<ipharo: #comm_open>
	anIPMessage inspect.
]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> debugEventHandler: anIPMessage [
	<ipharo: #debug_event>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> displayDataHanler: anIPMessage [
	<ipharo: #display_data>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> errorHandler: anIPMessage [
	<ipharo: #error>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> executeInputHandler: anIPMessage [
	<ipharo: #execute_input>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> executeResultHandler: anIPMessage [
	<ipharo: #execute_result>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> kernelSatatusHandler: anIPMessage [
	<ipharo: #status>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> streamHandler: anIPMessage [
	<ipharo: #stream>
	anIPMessage inspect
	

]

{ #category : #'message-handlers' }
IPIOTestMsgHandler >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>
	anIPMessage inspect
	

]
