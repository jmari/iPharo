Class {
	#name : #IPharoCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'JupyterTalk-Core'
}

{ #category : #accessing }
IPharoCommandLineHandler class >> commandName [
	^ 'ipharo'
]

{ #category : #accessing }
IPharoCommandLineHandler class >> description [
	^ 'Starts ipharo kernel'
]

{ #category : #activation }
IPharoCommandLineHandler >> activate [

	| ref stream kernelConfig content |
	self activateHelp ifTrue: [  ^ self ].
	self arguments notEmpty
		ifTrue:[
			ref :=self arguments first asFileReference .
			[	stream := ref readStreamIfAbsent: [ self error: 'Kernel config not found.' ].
				content := stream upToEnd.
			 	ZmqLog logDebug: content.	
			 	kernelConfig := SCMaterializer materializeFromString:content]
			ensure: [ stream ifNotNil: [ stream close ]]].
	ZmqContext current.
	IPharoKernel new 
						configKernel: kernelConfig;
						start.

]
