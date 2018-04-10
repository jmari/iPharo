visitor-interactions
visitLinkView: anInt with: el
	| eview name st exporter |
	eview := anInt viewFor: el.
	name := anInt nameFor: el.
	name ifNil: [ name := self nameFor: el ].
	
	[ 
	eview ifNotNil: [ 
		exporter := IPRoassal new 
			fileName: name, '.html';
			shouldCreateJS: false.
		exporter createStream.
		st := exporter stream.
		exporter export: eview toStream: st] 
	] on: Error do: [ :ex |
	st close.
	exporter export: anInt errorView ].
	stream 
		nextPutAll: 'new RTLinkView("';
		nextPutAll: name;
			nextPutAll: '")'.