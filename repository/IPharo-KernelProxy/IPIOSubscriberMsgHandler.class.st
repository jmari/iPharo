Class {
	#name : #IPIOSubscriberMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> clearOutputHandler: anIPMessage [
	<ipharo: #clear_output>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> debugEventHandler: anIPMessage [
	<ipharo: #debug_event>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> displayDataHanler: anIPMessage [
	<ipharo: #display_data>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> errorHandler: anIPMessage [
	<ipharo: #error>
	self evaluateListenersFor: anIPMessage 
	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> executeInputHandler: anIPMessage [
	<ipharo: #execute_input>
	self evaluateListenersFor: anIPMessage 
	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> executeResultHandler: anIPMessage [
	<ipharo: #execute_result>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> kernelSatatusHandler: anIPMessage [
	<ipharo: #status>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> streamHandler: anIPMessage [
	<ipharo: #stream>
	self evaluateListenersFor: anIPMessage 

	

]

{ #category : #'message-handlers' }
IPIOSubscriberMsgHandler >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>
	self evaluateListenersFor: anIPMessage 

	

]
