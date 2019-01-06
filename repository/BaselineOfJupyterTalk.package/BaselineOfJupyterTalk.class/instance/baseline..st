baselines
baseline: spec
	<baseline>
	spec for: #common do: [ 
		self installJson.
		spec
			package: 'ZeroMQ';
			package: 'JupyterTalk' with: [ spec requires: #('ZeroMQ') ];
			package: 'JupyterTalk-Roassal' with: [
				spec 
					requires: #('JupyterTalk');
					preLoadDoIt: #installRoassal
				].
		self groups: spec
	]