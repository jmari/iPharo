accessing
wireMessage
	"jupyter client sends:
		UUID 
		a message delimiter '<IDS|MSG>'
		'HMAC'
		'HEADER dictionary'
		'PARENT HEADER Dictionary'
		'METADATA Dictionary'
		'CONTENT Dictionary'
	we recieve one line at a time we check if there are more frames to come using.
	more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore"
	^	IPWireMessage new
		push: '0F50B50EF8A74BAB8208F9CD4220A10D';
		push: 'faa64554c56c018f7ba1fe76a7a99d37a59a75721c5dc362be9acce838e1b643';
		push: '{"msg_id":"6FB84513B7DA4A9B8ACBE5656B55B115","username":"username","session":"0F50B50EF8A74BAB8208F9CD4220A10D","msg_type":"execute_request","version":"5.0","date":"2018-05-04T14:31:03.597540Z"}';
		push: '{}';
		push: '{}';
		push: '{"code":"self display openInJupyter:(paisos column:#CONTINENT) asStringTable   ","silent":false,"store_history":true,"user_expressions":{},"allow_stdin":true,"stop_on_error":true}';
		yourself 