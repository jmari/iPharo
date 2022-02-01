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
		self nonCryptoHashes: spec.
		self createKernelFile.

		spec
			package: 'ZeroMQ';
			package: 'IPharo' with: [ 
				spec requires: #('ZeroMQ' 'SCouchDB' 'NonCryptographicHashes')];	
			package: 'Dap' with:[
				spec requires: #('ZeroMQ' 'SCouchDB' 'NonCryptographicHashes' 'IPharo-UIMAnager');
					preLoadDoIt: #pharoDAP];
			package: 'JupyterTalk-Roassal' with: [
				spec 
					requires: #('IPharo');
					preLoadDoIt: #installRoassal
				].
			
		self groups: spec ]
]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> createKernelFile [
	| listOfKernels first last  kernelPath kernelsDir fileRef outString stream |
	
	outString := LibC resultOfCommand: 'jupyter kernelspec list'.
	listOfKernels := outString findTokens: Character lf.
	2 to:listOfKernels size do:[ :index |
		first := (listOfKernels at: index) findString: ' ' startingAt: 12.
		last := (listOfKernels at: index) findString: 'kernels'.
		kernelPath := (listOfKernels at:index) copyFrom: first +2 to: last + 7.
		kernelsDir := (FileSystem root / kernelPath / 'pharo') createDirectory.  
		fileRef := kernelsDir / 'kernel.json'.  
		fileRef := fileRef ensureCreateFile.
		stream := fileRef writeStream.
		stream nextPutAll: self kernelFileContents.
		stream close ]


]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> getKernelFileReference [
	| listOfKernels first last  kernelPath kernelsDir fileRef outString |
	outString := LibC resultOfCommand: 'jupyter kernelspec list'.
	listOfKernels := outString findTokens: Character lf.
	2 to:listOfKernels size do:[ :index |
		first := (listOfKernels at: index) findString: ' ' startingAt: 12.
		last := (listOfKernels at: index) findString: 'kernels'.
		kernelPath := (listOfKernels at:index) copyFrom: first +2 to: last + 7.
		kernelsDir := (FileSystem root / kernelPath / 'pharo') createDirectory.  
		fileRef := kernelsDir / 'kernel.json'.  
		fileRef := fileRef ensureCreateFile ]
		

]

{ #category : #protocol }
BaselineOfIPharo >> groups: spec [
	spec 
		group: 'default' with: #('IPharo');
		group: 'zmq' with: #('ZeroMQ');
		group: 'dap' with: #('Dap');
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
BaselineOfIPharo >> kernelFileContents [
	
	^ '{
  "argv": [
  "', FileLocator vmBinary fullName,'",
  "--headless", "', FileLocator image fullName, '",
  "ipharo",
  "{connection_file}"
	],
	"display_name": "Pharo Smalltalk",
	"language": "smalltalk",
	"metadata": { "debugger": true }
	}'
]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> nonCryptoHashes: spec [
    spec
    	baseline: #NonCryptographicHashes
    	with: [ spec repository: 'github://osoco/pharo-non-cryptographic-hashes:master/src' ]

	


]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> pharoDAP [
		Metacello new
			baseline: 'PharoLanguageServer';
			repository: 'github://badetitou/Pharo-LanguageServer:v2/src' ;
			load: 'PharoDAP'


]

{ #category : #'as yet unclassified' }
BaselineOfIPharo >> pharoDAP:spec [

	spec 
		baseline: 'PharoLanguageServer' with: [ spec repository: 'github://badetitou/Pharo-LanguageServer:v2/src' ];
		import: 'PharoDAP'


]

{ #category : #'instance creation' }
BaselineOfIPharo >> pharoNonCryptographicHashes: spec [
    spec
    	baseline: #NonCryptographicHashes
    	with: [ spec repository: 'github://osoco/pharo-non-cryptographic-hashes:master/src' ];
		import: 'Core'
]
