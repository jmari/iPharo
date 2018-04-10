baselines
baseline: spec
	<baseline>
	spec for: #common do: [ 
		self json.
		spec
			package: 'ZeroMQ';
			package: 'JupyterTalk' with: [ spec requires: #('ZeroMQ') ];
			package: 'JupyterTalk-Roassal' with: [  spec requires: #('JupyterTalk') ].
		self groups: spec
	]