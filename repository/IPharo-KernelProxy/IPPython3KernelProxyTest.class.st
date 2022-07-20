Class {
	#name : #IPPython3KernelProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPPython3KernelProxyTest class >> defaultTimeLimit [
	^ 10 seconds
]

{ #category : #'system startup' }
IPPython3KernelProxyTest >> setUp [
		kernelProxy := IPPython3KernelProxy new.

]

{ #category : #accessing }
IPPython3KernelProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPPython3KernelProxyTest >> tearDown [
	kernelProxy stop.
	"give him time to receive the shutDown message"
	(Delay forMilliseconds: 300) wait.	
]

{ #category : #tests }
IPPython3KernelProxyTest >> testClientWidget [
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
IPPython3KernelProxyTest >> testExecuteRequest [
	| code response|
	code :='a=0'.
	response := kernelProxy executeRequest: code.
		
	self assert: (response content status ) equals: #ok.
]

{ #category : #tests }
IPPython3KernelProxyTest >> testKernelInfoRequest [
	| response |
	response := kernelProxy kernelInfoRequest.
	self assert: response uuid notNil
]

{ #category : #tests }
IPPython3KernelProxyTest >> testKernelWidget [
	| handler response receivedMessages|
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
	(Delay forMilliseconds: 1000) wait.
	self assert: receivedMessages isNotEmpty.

	
	
	
]

{ #category : #tests }
IPPython3KernelProxyTest >> testisCompleteInvalidRequest [
	| code response|
		
	code :='a=10.
	while a >= 0:'.
	response := kernelProxy isCompleteRequest: code.

	self assert: response content status equals: #incomplete
]

{ #category : #tests }
IPPython3KernelProxyTest >> testisCompleteRequest [
	| code response|
	code :='a=0'.
	response := kernelProxy isCompleteRequest: code.
		
	self assert: response content status equals: #complete.
	
]
