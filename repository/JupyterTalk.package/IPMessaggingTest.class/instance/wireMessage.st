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
		push: 'TEST';
		push: 'e1c8f884ffedef543b4a2b9f29acab51de278ffdda7e44dd927fd0c09eb674c9';
		push: '{"msg_id":"6FB84513B7DA4A9B8ACBE5656B55B115","username":"username","session":"TEST","msg_type":"execute_request","version":"5.0","date":"2018-05-04T14:31:03.597540Z"}';
		push: '{}';
		push: '{}';
		push: '{"code":"now:= DateAndTime now","silent":false,"store_history":true,"user_expressions":{},"allow_stdin":true,"stop_on_error":true}';
		yourself 