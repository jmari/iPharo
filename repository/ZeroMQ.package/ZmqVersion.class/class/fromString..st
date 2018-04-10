as yet unclassified
fromString: aString
	"Conerts minor.major.patch version string e.g. 1.34.12 to ZmqVersion object"

	^self fromArray: ((aString splitOn: $.) collect: [ :part | part asInteger ]) asArray