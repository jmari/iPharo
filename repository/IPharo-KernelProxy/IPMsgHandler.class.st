"
I am an example of how can we implement a MessageHandler for our application. Create a class  like mw, using pragma <ipharo: #message_type> inside the hendler methods
"
Class {
	#name : #IPMsgHandler,
	#superclass : #Object,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPMsgHandler >> commCloseHandler: anIPMessage [
	<ipharo: #comm_close>
]

{ #category : #'as yet unclassified' }
IPMsgHandler >> commMessageHandler: anIPMessage [
	<ipharo: #comm_msg>
	anIPMessage inspect
]

{ #category : #'as yet unclassified' }
IPMsgHandler >> commOpenHandler: anIPMessage [
	<ipharo: #comm_open>
	anIPMessage inspect.
]

{ #category : #'message-handlers' }
IPMsgHandler >> debugEventHandler: anIPMessage [
	<ipharo: #debug_event>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> displayDataHanler: anIPMessage [
	<ipharo: #display_data>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> errorHandler: anIPMessage [
	<ipharo: #error>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> executeHandler: anIPMessage [
	<ipharo: #execute_result>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> executeInputHandler: anIPMessage [
	<ipharo: #execute_input>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> executeResultHandler: anIPMessage [
	<ipharo: #execute_result>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> kernelSatatusHandler: anIPMessage [
	<ipharo: #status>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> streamHandler: anIPMessage [
	<ipharo: #stream>

	

]

{ #category : #'message-handlers' }
IPMsgHandler >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>

	

]
