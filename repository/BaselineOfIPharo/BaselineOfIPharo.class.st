Class {
	#name : #BaselineOfIPharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfIPharo
}

{ #category : #baselines }
BaselineOfIPharo >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		self json: spec.
		Smalltalk os isWindows ifFalse:[ 
			"OSSubprocess does not support Windows"
			self osSubprocess: spec.
			self createKernelFile].
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

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> createKernelFile [
	
	| contents kernelFile stream |
	contents := '{
  "argv": [
  "', FileLocator vmBinary fullName,'",
  "--headless", "', FileLocator image fullName, '",
  "ipharo",
  "{connection_file}"
	],
	"display_name": "Pharo Smalltalk",
	"language": "smalltalk"
	}'.
	kernelFile := self getKernelFileReference.
	stream := kernelFile writeStream.
	stream nextPutAll: contents.
	stream close.
]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> getKernelFileReference [
	| listOfKernels first last  kernelPath kernelsDir fileRef |
	OSSUnixSubprocess new
		command: 'jupyter';
		arguments: #('kernelspec' 'list');
		redirectStdout;
		runAndWaitOnExitDo: [ :process :outString  | 
				listOfKernels := outString findTokens: Character lf.
				first := (listOfKernels at:2) findString: ' ' startingAt:12.
				last := (listOfKernels at:2) findString: 'kernels'. 
				kernelPath := (listOfKernels at:2) copyFrom: first +2 to: last + 7
				].
		kernelsDir := (FileSystem root / kernelPath / 'pharo') createDirectory.  
		fileRef := kernelsDir / 'kernel.json'.  
		fileRef := fileRef ensureCreateFile.
		^ fileRef
		

]

{ #category : #protocol }
BaselineOfIPharo >> groups: spec [
	spec 
		group: 'default' with: #('JupyterTalk');
		group: 'zmq' with: #('ZeroMQ');
		group: 'roassalSupport' with: #('JupyterTalk-Roassal');
		group: 'all' with: #('JupyterTalk-Roassal')
]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> installRoassal [
	"ROASSAL 3 is not supported"
	| installRoassal |
	(Smalltalk globals includesKey:#RTBuilder ) ifTrue:[ ^ self ].
	
	installRoassal :=(UIManager default questionWithoutCancel: 'Roassal is required, do you want to Install Roassal 2 in your Image?').
	(installRoassal)
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
			]
]

{ #category : #'instance creation' }
BaselineOfIPharo >> json: spec [
	spec 
		baseline: 'SCouchDB' with: [ spec repository: 'github://jmari/SCouchDB/repository' ];
		import: 'json'
]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> osSubprocess: spec [
	spec 
		baseline: 'OSSubprocess' with: [ 
			spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ];
		import: 'all'


]
