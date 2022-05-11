Class {
	#name : #IPControlMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPControlMsgHandler >> debugHandler: anIPMessage [
	<ipharo: #debug_reply>
	self evaluateListenersFor: anIPMessage

	

]

{ #category : #'message-handlers' }
IPControlMsgHandler >> interruptHandler: anIPMessage [
	<ipharo: #interrupt_reply>
	self evaluateListenersFor: anIPMessage

	

]
