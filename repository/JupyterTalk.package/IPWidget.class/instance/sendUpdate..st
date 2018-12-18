remote-notification
sendUpdate:kv
	
	self comm ifNotNil:[
		self comm send: { 'method'->'update'.
							'state'-> {kv} asDictionary  asSCJsonObject  } asSCJsonObject]