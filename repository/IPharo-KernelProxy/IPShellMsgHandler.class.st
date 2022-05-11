Class {
	#name : #IPShellMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPShellMsgHandler >> commInfoHandler: anIPMessage [
	<ipharo: #comm_info_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> completeHandler: anIPMessage [
	<ipharo: #complete_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> debugHandler: anIPMessage [
	<ipharo: #debug_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> executeHandler: anIPMessage [
	<ipharo: #execute_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> historyHandler: anIPMessage [
	<ipharo: #history_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> inspectHandler: anIPMessage [
	<ipharo: #inspect_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> isCompleteHandler: anIPMessage [
	<ipharo: #is_complete_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPShellMsgHandler >> kernelInfoHandler: anIPMessage [
	<ipharo: #kernel_info_reply>
	self evaluateListenersFor: anIPMessage

	

]
