Class {
	#name : #IPCustomMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPCustomMsgHandler >> commCloseHandler: anIPMessage [
	<ipharo: #comm_close>
	self evaluateListenersFor: anIPMessage 
]

{ #category : #'message-handlers' }
IPCustomMsgHandler >> commMessageHandler: anIPMessage [
	<ipharo: #comm_msg>
	self evaluateListenersFor: anIPMessage 
]

{ #category : #'message-handlers' }
IPCustomMsgHandler >> commOpenHandler: anIPMessage [
	<ipharo: #comm_open>
	self evaluateListenersFor: anIPMessage 
]
