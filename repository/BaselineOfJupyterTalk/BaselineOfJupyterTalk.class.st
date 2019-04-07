Class {
	#name : #BaselineOfJupyterTalk,
	#superclass : #BaselineOf,
	#category : 'BaselineOfJupyterTalk'
}

{ #category : #baselines }
BaselineOfJupyterTalk >> baseline: spec [
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
]

{ #category : #protocol }
BaselineOfJupyterTalk >> groups: spec [
	spec 
		group: 'default' with: #('JupyterTalk');
		group: 'zmq' with: #('ZeroMQ');
		group: 'roassalSupport' with: #('JupyterTalk-Roassal');
		group: 'all' with: #('JupyterTalk-Roassal')
]

{ #category : #'as yet unclassified' }
BaselineOfJupyterTalk >> installJson [
	Metacello new 
		baseline: 'SCouchDB';
		repository: 'github://jmari/SCouchDB/repository';
		load:'json'
]

{ #category : #'as yet unclassified' }
BaselineOfJupyterTalk >> installRoassal [
	(Smalltalk includesKey:#RTBuilder )
		ifFalse:[
			(UIManager default questionWithoutCancel: 'Roassal is required, do you want to Install Roassal 2 in your Image?')
					ifTrue:[
						SystemVersion current major >= 7
						ifTrue:[
							Metacello new
    						baseline: 'Roassal2';
    						repository: 'github://ObjectProfile/Roassal2/src';
    						load]
						ifFalse:[
							Gofer it
							smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
							configurationOf: 'Roassal2';
							loadStable]
					]]
]
