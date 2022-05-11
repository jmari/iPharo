Class {
	#name : #IPStdInMsgHandler,
	#superclass : #IPMsgHandler,
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'as yet unclassified' }
IPStdInMsgHandler >> inputReplayHandler: anIPMessage [
	<ipharo: #input_reply>
	self evaluateListenersFor: anIPMessage 
]

{ #category : #'as yet unclassified' }
IPStdInMsgHandler >> inputRequestHandler: anIPMessage [
	<ipharo: #input_request>
	| userResponse |
	userResponse :=anIPMessage content password 
		ifTrue:[ UIManager default requestPassword: anIPMessage content prompt ]
		ifFalse:[ UIManager default request: anIPMessage content prompt ].
	

	
]
