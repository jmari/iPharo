tests
testTaskVent
	| sender sink gen totalMilliseconds workLoad |
	self setUp.
	sender := self newPushSocket.
	sender bind:'tcp://*:5557'.
	sink :=  self newPushSocket.
	sink connect: 'tcp://localhost:5558'.
	sink send:'0'asByteArray.
	gen := Random seed: 2000.
	totalMilliseconds := 0.
	workLoad := 0.
	self startWorkers.
	(Delay forMilliseconds: 3000) wait.
	0 to:self numberOfWorkers do:[:each|
		workLoad :=	(gen nextInt:100) + 1.
		totalMilliseconds := totalMilliseconds + workLoad.
		Transcript show:( totalMilliseconds asString); cr.
		sender send:workLoad asString asByteArray].
