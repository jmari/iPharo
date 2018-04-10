instance creation
newWorker
	
	^ [|receiver sender data|
		receiver := self newPullSocket.
		receiver connect: 'tcp://localhost:5557'.
		sender := self newPushSocket.
		sender connect: 'tcp://localhost:5557'.
		[true] whileTrue:[
			data := receiver receive.
			sender send: data.
			Transcript show:('Waiting for:',data asString);crlf.
			Processor yield.
			(Delay forMilliseconds: (Integer newFrom: data) ) wait ]
	 ] fork
	