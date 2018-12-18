state-accessors
label
	| op index |
	index := 0.
	op := self getProperty: #_options_labels.
	index := self getProperty: #index.
	^ op at:(index + 1)