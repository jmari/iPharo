state-accessors
options
	| keys values d |
	keys := self getProperty: #_options_labels.
	values := self getProperty: #_options_values.
	values 
		ifNil:[d:=keys]
		ifNotNil: [  
			d := Dictionary new.
			keys doWithIndex: [:k :i|
			d at:k put: (values at:i)]].
	^ d
