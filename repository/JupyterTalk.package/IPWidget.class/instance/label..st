state-accessors
label: aStringOrArray
	| op index indexes |
	index := 0.
	(aStringOrArray isKindOf:String)
		ifTrue:[ 
			op := self getProperty: #_options_labels.
			index := op indexOf: aStringOrArray.
			self setProperty: #index value: index - 1]
		ifFalse:[
			"must be an array of strings"
			op := self getProperty: #_options_labels.
			indexes := aStringOrArray collect:[:e| (op indexOf: e ) - 1].
			self setProperty: #index value: indexes]
		