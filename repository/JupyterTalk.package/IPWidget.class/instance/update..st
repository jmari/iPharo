display
update:kv
	self comm send: { 'method'->'update'.
							'state'-> {kv} asDictionary  asSCJsonObject  } asSCJsonObject