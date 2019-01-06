baselines
baseline: spec
	<baseline>
	spec for: #common do: [ 
		self installJson.
		spec
			package: 'ZeroMQ';
			package: 'JupyterTalk' with: [ spec requires: #('ZeroMQ') ];
			package: 'JupyterTalk-Roassal' with: [
				Smalltalk at:#RTBuilder 
				ifPresent:[spec requires: #('JupyterTalk') ]
				ifAbsent:[
					(UIManager default questionWithoutCancel: 'Roassal is required, do you want to Install Roassal 2 in your Image?')
					ifTrue:[
						self installRoassal.
						spec requires: #('JupyterTalk') ]]
				].
		self groups: spec
	]