baselines
groups: spec
	spec 
		group: 'default' with: #('JupyterTalk');
		group: 'zmq' with: #('ZeroMQ');
		group: 'roassalSupport' with: #('JupyterTalk-Roassal');
		group: 'all' with: 
			(Smalltalk at: #RTBuilder ifPresent:[ #('JupyterTalk-Roassal')] ifAbsent:[#('JupyterTalk')])