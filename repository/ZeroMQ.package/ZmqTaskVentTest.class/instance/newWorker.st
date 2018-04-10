instance creation
newWorker
	
	^ [|receiver sender data run|
		run := true.
		receiver := self newPullSocket.
		receiver connect: 'tcp://localhost:5557'.
		sender := self newPushSocket.
		sender connect: 'tcp://localhost:5558'.
		[run] whileTrue:[
			data := receiver receive.
			data isEmpty 
						ifTrue:[
							Processor yield]
						ifFalse:[
							Transcript show:('Rec:',data asString);cr.
							sender send: data asByteArray.
							Transcript show:('Waiting for:',data asString);cr.
							Processor yield.
							(Delay forMilliseconds: (Integer readFrom: data asString) ) wait]]
						
	 ] fork
	