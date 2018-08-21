parsing
pushMessageFrame:messageData 
	Transcript show: '-', messageData asString;cr.
	(messageData =  (self messageDelimiter asByteArray))
				ifFalse:[ self wireMessage push:messageData ]

						
	
