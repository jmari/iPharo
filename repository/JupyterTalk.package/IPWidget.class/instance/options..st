state-accessors
options: anObject
	(anObject isKindOf: Dictionary ) ifTrue:[
		self setProperty: #_options_labels value: anObject keys.
		self setProperty: #_options_values value: anObject values].
	(anObject isKindOf: ArrayedCollection  ) ifTrue:[
		(anObject first isKindOf: String ) 
		ifTrue:[
			self setProperty: #_options_labels value: anObject]
		ifFalse:[
			self setProperty: #_options_labels value: (anObject collect: [:i| i first]).
			self setProperty: #_options_values value: (anObject collect: [:i| i last])]]
					