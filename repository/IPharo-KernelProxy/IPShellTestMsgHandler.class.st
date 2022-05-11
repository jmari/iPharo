Class {
	#name : #IPShellTestMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> commInfoHandler: anIPMessage [
	<ipharo: #comm_info_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> completeHandler: anIPMessage [
	<ipharo: #complete_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> debugHandler: anIPMessage [
	<ipharo: #debug_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> executeHandler: anIPMessage [
	<ipharo: #execute_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> historyHandler: anIPMessage [
	<ipharo: #history_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> inspectHandler: anIPMessage [
	<ipharo: #inspect_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> isCompleteHandler: anIPMessage [
	<ipharo: #is_complete_reply>
	anIPMessage inspect

	

]

{ #category : #'message-handlers' }
IPShellTestMsgHandler >> kernelInfoHandler: anIPMessage [
	<ipharo: #kernel_info_reply>
	anIPMessage inspect

	

]
