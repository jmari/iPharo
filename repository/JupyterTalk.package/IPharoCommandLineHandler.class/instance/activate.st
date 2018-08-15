activation
activate

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
