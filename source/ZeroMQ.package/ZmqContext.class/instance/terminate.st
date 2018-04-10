controlling
terminate
	globalPoller ifNotNil:[ globalPoller stopPolling ].
	resources do: [ :zmqSocket | zmqSocket privateClose ].
	resources removeAll.
	self privateTerminate.
	self become: ZmqTerminatedContext new.