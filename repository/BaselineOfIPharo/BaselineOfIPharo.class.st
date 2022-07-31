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
		spec
		 	postLoadDoIt: #postLoadIt;
			package: 'ZeroMQ';
			package: 'IPharo' with: [ 
				spec requires: #('ZeroMQ' 'SCouchDB' 'NonCryptographicHashes')];
			package: 'IPharo-KernelProxy' with: [ spec requires: #('IPharo')  ];	
			package: 'IPharo-DAP' with:[
				spec requires: #('IPharo');
					preLoadDoIt: #pharoDAP];
			package: 'IPharo-Roassal3' with:[ 
				spec requires: #('IPharo');
					preLoadDoIt: #installRoassal3Exporters];
			package: 'JupyterTalk-Roassal' with: [
				spec 
					requires: #('IPharo');
					preLoadDoIt: #installRoassal
				].
			
		self groups: spec ]
]

{ #category : #private }
BaselineOfIPharo >> createKernelFile [
	"Create a kernel.json file if not was previously created"
	| kernelFile |

 	(kernelFile := self getKernelFileReference) size = 0
 		ifTrue: [ kernelFile writeStreamDo: [ : stream | stream nextPutAll: self kernelFileContents ] ]

]

{ #category : #defaults }
BaselineOfIPharo >> defaultKernelFileContents [ 
 	"Answer a <String> with the default kernel.json contents for IPharo kernels"

 	^ '\{
	 "argv": [
		"{vmBinaryFullName}",
 		"--headless", 
 		"{imageFullName}",
 		"ipharo",
 		"\{connection_file\}"
 	],
	"display_name": "Pharo Smalltalk",
 	"language": "smalltalk"
 	\}' format: { 
 		'vmBinaryFullName' -> FileLocator vmBinary fullName .
 		'imageFullName' ->  FileLocator image fullName } asDictionary.

]

{ #category : #private }
BaselineOfIPharo >> defaultKernelPathname [ 
 	"Answer a <String> with the location where the kernel.json file will be stored"

 	^ 'IPharo'
		

]

{ #category : #private }
BaselineOfIPharo >> getKernelFileReference [
	| kernelPath outString kernelsDir fileRef |
	outString := LibC resultOfCommand: 'jupyter kernelspec list'.
	kernelPath := self parseKernelPath: outString.
	kernelsDir := kernelPath 
 		ifEmpty: [ (FileSystem workingDirectory / self defaultKernelPathname) ensureCreateDirectory ]
 		ifNotEmpty: [ kernelPath ].
	(fileRef := kernelsDir asFileReference / 'kernel.json' ) exists
 		ifTrue: [ 
 			Smalltalk tools workspace openContents: fileRef contents.
 			(UIManager default confirm: 
				'An existing kernel.json was found at ' , fileRef fullName ,
  				' do you want to overwrite it with a new one?')
 				ifTrue: [
 					fileRef ensureDelete.
 					fileRef := (kernelsDir asFileReference / 'kernel.json') ensureCreateFile ] ]
 		ifFalse: [ fileRef := fileRef ensureCreateFile ].
 	^ fileRef
		

]

{ #category : #protocol }
BaselineOfIPharo >> groups: spec [
	spec 
		group: 'default' with: #('IPharo');
		group: 'proxy' with: #('IPharo-KernelProxy');
		group: 'zmq' with: #('ZeroMQ');
		group: 'dap' with: #('IPharo-DAP');
		group: 'roassal3' with: #('IPharo-Roassal3'); 
		group: 'roassal2' with: #('JupyterTalk-Roassal');
		group: 'all' with: #('IPharo-Roassal3')
]

{ #category : #installation }
BaselineOfIPharo >> installRoassal [
	"ROASSAL 3 is not supported"
	| installRoassal |
	(Smalltalk globals includesKey:#RTBuilder ) ifTrue:[ ^ self ].
	
	installRoassal :=(UIManager default questionWithoutCancel: 'Roassal 2 is required, do you want to Install Roassal 2 in your Image?').
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

{ #category : #installation }
BaselineOfIPharo >> installRoassal3Exporters [
	
	Metacello new
	    baseline: 'Roassal3Exporters';
	    repository: 'github://ObjectProfile/Roassal3Exporters';
	    load.
]

{ #category : #installation }
BaselineOfIPharo >> json: spec [
	spec 
		baseline: 'SCouchDB' with: [ spec repository: 'github://jmari/SCouchDB/repository' ];
		import: 'json'
]

{ #category : #defaults }
BaselineOfIPharo >> kernelFileContents [
	"if we find pharo file in this path we assume that we are installing on docker"
	| fr |
	fr := '/opt/pharo/pharo' asFileReference.
	^ fr exists
		ifTrue:[ self kernelFileContentsForDocker ]
		ifFalse:[ self defaultKernelFileContents  ]
]

{ #category : #defaults }
BaselineOfIPharo >> kernelFileContentsForDocker [
	
 	^ '\{
	 "argv": [
		"{vmBinaryFullName}",
 		"{imageFullName}",
 		"ipharo",
 		"\{connection_file\}"
 	],
	"display_name": "Pharo Smalltalk",
 	"language": "smalltalk",
	"metadata": { "debugger": true }
 	\}' format: { 
 		'vmBinaryFullName' -> '/opt/pharo/pharo'.
 		'imageFullName' ->  FileLocator image fullName } asDictionary.
		
	
]

{ #category : #private }
BaselineOfIPharo >> kernelNames [ 

 	^ #('bash' 'ir' 'julia' 'octave' 'python' 'sagemath')


]

{ #category : #installation }
BaselineOfIPharo >> nonCryptoHashes: spec [
    spec
    	baseline: #NonCryptographicHashes
    	with: [ spec repository: 'github://osoco/pharo-non-cryptographic-hashes:master/src' ]

	


]

{ #category : #private }
BaselineOfIPharo >> parseGenericKernelPathCandidates: aCollection [ 
 	"Answer a <String> with the first path which does not look like a standard kernel for other programming languages than Pharo.
 	If none, answer an empty <Collection>"

 	aCollection pairsDo: [ : kernelName : kernelPath |
 		(self kernelNames includes: kernelName) 
 			ifFalse: [ ^ kernelPath ] ].
 	^ String empty

]

{ #category : #private }
BaselineOfIPharo >> parseKernelPath: outString [ 
 	"Answer a <String> with the path where to install the IPharo kernel.
 	Sample output to parse from command:
 $ jupyter kernelspec list
 Available kernels:
   python3    				/usr/local/Cellar/jupyterlab/3.4.3/libexec/lib/python3.10/site-packages/ipykernel/resources
   ipharo     				/usr/local/share/jupyter/kernels/ipharo
   global-tf-python-3    /home/felipe/.local/share/jupyter/kernels/global-tf-python-3
   local_venv2           /home/felipe/.local/share/jupyter/kernels/local_venv2
   python2               /home/felipe/.local/share/jupyter/kernels/python2
   python36              /home/felipe/.local/share/jupyter/kernels/python36
   scala                 /home/felipe/.local/share/jupyter/kernels/scala	
 "

 	(outString asLowercase beginsWith: 'available')
 		ifTrue: [ 
 			| listOfKernels candidateKernelSpecs |
 			(listOfKernels := outString lines allButFirst) 
 				ifEmpty: [ ^ Array empty ].
 			candidateKernelSpecs := (listOfKernels collect: #trimBoth) collect: [ : kernelSpec | kernelSpec findTokens: ' ' ].
 			^ self parsePharoKernelPathCandidates: candidateKernelSpecs ].
 	^ String empty


]

{ #category : #private }
BaselineOfIPharo >> parsePharoKernelPathCandidates: aCollection [ 
 	"Answer a <String> with a suitable location where to store the kernel.json file for IPharo, or empty if not found"

 	^ aCollection 
 		detect: [ : locationSpecArray | 
 			| specName |
 			specName := locationSpecArray first asLowercase.
 			(specName beginsWith: 'pharo') or: [ specName endsWith: 'pharo' ]  ]
 		ifFound: [ : found | found second ]
 		ifNone: [ self parseGenericKernelPathCandidates: aCollection ]


]

{ #category : #installation }
BaselineOfIPharo >> pharoDAP [
		Metacello new
			baseline: 'PharoLanguageServer';
			repository: 'github://badetitou/Pharo-LanguageServer:v2/src' ;
			load: 'PharoDAP'


]

{ #category : #installation }
BaselineOfIPharo >> pharoDAP:spec [

	spec 
		baseline: 'PharoLanguageServer' with: [ spec repository: 'github://badetitou/Pharo-LanguageServer:v2/src' ];
		import: 'PharoDAP'


]

{ #category : #installation }
BaselineOfIPharo >> pharoNonCryptographicHashes: spec [
    spec
    	baseline: #NonCryptographicHashes
    	with: [ spec repository: 'github://osoco/pharo-non-cryptographic-hashes:master/src' ];
		import: 'Core'
]

{ #category : #private }
BaselineOfIPharo >> postLoadIt [ 

 	Smalltalk os isWindows 
 		ifFalse: [ self createKernelFile ]
 		ifTrue: [ Smalltalk tools workspace openContents: self windowsUnsupportedSteps  ].
 	Smalltalk tools workspace openContents: '"Now you can save and quit this image and run from your CLI: 
 	
 	jupyter notebook"'

]

{ #category : #private }
BaselineOfIPharo >> windowsUnsupportedSteps [ 

 	^ String streamContents: [ : stream |
 		stream
 			<< '"OSSubProcess does not work currently on Windows. Please type the following command in your CLI:';
 			cr; cr;
 			<< 'jupyter kernelspec list';
 			cr; cr;
 			<< 'and create manually the kernel.json file in your preferred location, with the following contents: ';
 			cr; cr;
 			<< self defaultKernelFileContents;
 			<< '"' ]
]
