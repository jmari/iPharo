tests
taskVent
	| sender sink gen totalMilliseconds workLoad |
	sender := self newPushSocket.
	sender bind:'tcp://*:5557'.
	sink :=  self newPushSocket.
	sink connect: 'tcp://localhost:5558'.
	sink send:'0'asByteArray.
	gen := Random seed: 2000.
	totalMilliseconds := 0.
	workLoad := 0.
	0 to:self numberOfWorkers do:[:each|
		workLoad :=	(gen nextInt:100) + 1.
		totalMilliseconds := totalMilliseconds + workLoad.
		Transcript show:( totalMilliseconds asString); cr.
		sink send:workLoad asString asByteArray]
	