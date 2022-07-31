Class {
	#name : #IPPython3KernelProxy2Test,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPPython3KernelProxy2Test class >> defaultTimeLimit [
	^ 20 seconds
]

{ #category : #'system startup' }
IPPython3KernelProxy2Test >> setUp [
	kernelProxy := IPPython3KernelProxy new.

]

{ #category : #accessing }
IPPython3KernelProxy2Test >> sourceCode [
	^ 'a=0
b=1
c=2
display(a)
display(b)
display(c)
'
]

{ #category : #'system startup' }
IPPython3KernelProxy2Test >> tearDown [
	kernelProxy stop.
	"give him time to receive the shutDown message"
	(Delay forMilliseconds: 300) wait.	
	
]

{ #category : #tests }
IPPython3KernelProxy2Test >> testClientWidget [
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
IPPython3KernelProxy2Test >> testExecuteRequest [
	| code response|
	code := self sourceCode.
	kernelProxy 
		onExecuteReplyDo: [ :aMessage | response := aMessage ];
		onExecuteResultPublishedDo: [ :aMessage| response := aMessage ];
		onDisplayDataPublishedDo: [ :aMessage| response := aMessage].
	kernelProxy executeRequest: code.
	"[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait]."

	self assert: response content data notNil.

]

{ #category : #tests }
IPPython3KernelProxy2Test >> testExecuteRequest2 [
	| handler response receivedMessages|
	"in order to handle widget you should create an IPWidgetMsgHandler and add it to the 
	 IO subscriber queue, it will handle the widget creation in client side "
	receivedMessages := OrderedCollection new.
	handler := IPIOTestMsgHandler new.
	kernelProxy addHandlerToIOSubscriber:  handler.

	response := kernelProxy executeRequest: 'a=1
b=2
c=3
display(c)'.
	
	(Delay forMilliseconds: 2000) wait.
	self assert: receivedMessages isNotEmpty.

	
	
	
]

{ #category : #tests }
IPPython3KernelProxy2Test >> testKernelInfoRequest [
	| response |
	kernelProxy 
		onKernelInfoReplyDo: [ :msg | response := msg ];
		kernelInfoRequest.		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	

	self assert: response uuid notNil
]

{ #category : #tests }
IPPython3KernelProxy2Test >> testKernelWidget [
	| handler response receivedMessages|
	"in order to handle widget you should create an IPWidgetMsgHandler and add it to the 
	 IO subscriber queue, it will handle the widget creation in client side "
	receivedMessages := OrderedCollection new.
	handler := IPWidgetMsgHandler new. 
	handler onMessage:#comm_msg do:[:aMessage|
		receivedMessages add:aMessage.
		aMessage inspect  ].
	kernelProxy addHandlerToIOSubscriber:  handler.

	response := kernelProxy executeRequest: 'import ipywidgets as widgets
w = widgets.IntSlider(
	value = 7,
	min = 0,
	max = 10,
	step =1,
	description = ''Test'',
	disabled = False,
	continuousUpdate = False,
	orientation = ''horizontal'',
	readout = True,
	readoutFormat =''d'',
)
w.value=5
w.disabled = True
display(w)'.
	
	(Delay forMilliseconds: 2000) wait.
	self assert: receivedMessages isNotEmpty.

	
	
	
]

{ #category : #tests }
IPPython3KernelProxy2Test >> testisCompleteInvalidRequest [
	| code response|
		
	code :='a=10.
	while a >= 0:'.
	kernelProxy 	
		onIsCompleteReplyDo: [ :msg | response := msg ];
		isCompleteRequest: code.
		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	

	self assert: response content status equals: #incomplete
]

{ #category : #tests }
IPPython3KernelProxy2Test >> testisCompleteRequest [
	| code response|
	code :='a=0'.
	
	kernelProxy 
		onIsCompleteReplyDo: [ :msg | response := msg ];
		isCompleteRequest: code.
		
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].	
	self assert: response content status equals: #complete.
	
]
