Class {
	#name : #IPIOPubSubscriberMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> clearOutputHandler: anIPMessage [
	<ipharo: #clear_output>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> debugEventHandler: anIPMessage [
	<ipharo: #debug_event>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> displayDataHanler: anIPMessage [
	<ipharo: #display_data>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> errorHandler: anIPMessage [
	<ipharo: #error>
	self evaluateListenersFor: anIPMessage 
	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> executeInputHandler: anIPMessage [
	<ipharo: #execute_input>
	self evaluateListenersFor: anIPMessage 
	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> executeResultHandler: anIPMessage [
	<ipharo: #execute_result>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> kernelSatatusHandler: anIPMessage [
	<ipharo: #status>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> streamHandler: anIPMessage [
	<ipharo: #stream>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOPubSubscriberMsgHandler >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>
	self evaluateListenersFor: anIPMessage 

	

]
