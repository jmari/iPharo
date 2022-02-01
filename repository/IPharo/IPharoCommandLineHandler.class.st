"
I m the command line handler. I start the pharo kernel passing a JSON read from the configuration file.

"
Class {
	#name : #IPharoCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'IPharo-Core'
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
	self activateHelp not and:[
		self arguments notEmpty
		ifTrue:[
			ref :=self arguments first asFileReference .
			stream := ref readStreamIfAbsent: [ self error: 'Kernel config not found.' ].
			content := stream upToEnd.
			ZmqLog logDebug: content.	
			kernelConfig := SCMaterializer materializeFromString:content. 
			stream close.
			ZmqContext current.
			Smalltalk at:#CommandLineDapUIManager ifPresent:[
			CommandLineDapUIManager isValidForCurrentSystemConfiguration ifTrue:[ 
				CommandLineDapUIManager new beDefault.
				 ] ].
			IPharoKernel new 
						configureKernel: kernelConfig;
						start ] ]

]
