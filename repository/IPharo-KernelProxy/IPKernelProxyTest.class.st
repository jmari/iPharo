Class {
	#name : #IPKernelProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPKernelProxyTest class >> defaultTimeLimit [
	^ 20 seconds
]

{ #category : #'system startup' }
IPKernelProxyTest >> setUp [
	kernelProxy := IPIPharoKernelProxy new.

]

{ #category : #accessing }
IPKernelProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPKernelProxyTest >> tearDown [
	kernelProxy stop.
	"give him time to receive the shutDown message"
	(Delay forMilliseconds: 300) wait.	
	
]

{ #category : #tests }
IPKernelProxyTest >> testClientWidget [
	| widget handler response |
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandlerToIOSubscriber:  handler.
	widget := kernelProxy widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.

	response :=kernelProxy commMessageRequest: widget comm uuid  data: 
					{ #method-> #request_state.
						#target->'jupyter.widget' } asSCJsonObject.
	"still 5"
	self assert: widget value equals:5.

	
	
]

{ #category : #tests }
IPKernelProxyTest >> testExecuteRequest [
	| code response|
	code := self sourceCode.
	kernelProxy 
		onExecuteResultPublishedDo: [ :aMessage| response := aMessage ];
		onStreamPublishedDo: [ :aMessage| response := aMessage].
	kernelProxy executeRequest: code.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].

	self assert: response content data notNil.

]

{ #category : #tests }
IPKernelProxyTest >> testKernelInfoRequest [
	| response |
	kernelProxy 
		onKernelInfoReplyDo: [ :msg | response := msg ];
		kernelInfoRequest.		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	

	self assert: response uuid notNil
]

{ #category : #tests }
IPKernelProxyTest >> testKernelWidget [
	| handler response receivedMessages|
	"in order to handle widget you should create an IPWidgetMsgHandler and add it to the 
	 IO subscriber queue, it will handle the widget creation in client side "
	receivedMessages := OrderedCollection new.
	handler := IPWidgetMsgHandler new. 
	handler onMessage:#comm_msg do:[:aMessage|
		receivedMessages add:aMessage.
		aMessage inspect  ].
	kernelProxy addHandlerToIOSubscriber:  handler.

	response := kernelProxy executeRequest: '
	widget:=self widgetFactory intSlider
                                value:7;
                                min:0;
                                max:10;
                                step:1;
                                description:''Test'';
                                disabled:false;
                                continuousUpdate:false;
                                orientation:''horizontal'';
                                readout:true;
                                readoutFormat:''d''.'.
	
	(Delay forMilliseconds: 2000) wait.
	self assert: receivedMessages isNotEmpty.

	
	
	
]

{ #category : #tests }
IPKernelProxyTest >> testisCompleteInvalidRequest [
	| code response|
		
	code :='a:=10.
	[a >= 0] whileTrue:['.
	kernelProxy 	
		onIsCompleteReplyDo: [ :msg | response := msg ];
		isCompleteRequest: code.
		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	

	self assert: response content status equals: #invalid
]

{ #category : #tests }
IPKernelProxyTest >> testisCompleteRequest [
	| code response|
	code :='a:=0'.
	
	kernelProxy 
		onIsCompleteReplyDo: [ :msg | response := msg ];
		isCompleteRequest: code.
		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	
	self assert: response content status equals: #complete.
	
]
