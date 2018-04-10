testing
< aZMQVersion
	self major < aZMQVersion major ifTrue:[^true].
	self major > aZMQVersion major ifTrue:[^false].
	self minor < aZMQVersion minor ifTrue:[^true].
	self minor > aZMQVersion minor ifTrue:[^false].
	self patch < aZMQVersion patch ifTrue:[^true].
	self patch > aZMQVersion patch ifTrue:[^false].		
	^false.