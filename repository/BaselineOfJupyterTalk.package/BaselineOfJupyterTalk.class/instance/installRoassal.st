as yet unclassified
installRoassal
	(Smalltalk includesKey:#RTBuilder )
		ifFalse:[
			(UIManager default questionWithoutCancel: 'Roassal is required, do you want to Install Roassal 2 in your Image?')
					ifTrue:[
						Gofer it
							smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
							configurationOf: 'Roassal2';
							loadStable.
					]]