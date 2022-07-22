Class {
	#name : #BaselineOfJupyterTalk,
	#superclass : #BaselineOf,
	#category : #BaselineOfJupyterTalk
}

{ #category : #baselines }
BaselineOfJupyterTalk >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		self installDependencies: spec.
		spec postLoadDoIt: #postLoadIt.
		spec
			package: 'ZeroMQ';
			package: 'JupyterTalk' with: [ spec requires: #('ZeroMQ' 'OSSubProcess') ];
			package: 'JupyterTalk-Roassal' with: [
				spec 
					requires: #('JupyterTalk');
					preLoadDoIt: #installRoassal ].
		self groups: spec ]
]

{ #category : #private }
BaselineOfJupyterTalk >> createKernelFile [
	"Create a kernel.json file if not was previously created"
	
	| kernelFile |

	(kernelFile := self getKernelFileReference) size = 0
		ifTrue: [ kernelFile writeStreamDo: [ : stream | stream nextPutAll: self defaultKernelFileContents ] ].

]

{ #category : #defaults }
BaselineOfJupyterTalk >> defaultKernelFileContents [
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

{ #category : #defaults }
BaselineOfJupyterTalk >> defaultKernelPathname [
	"Answer a <String> with the location where the kernel.json file will be stored"

	^ 'IPharo'
]

{ #category : #private }
BaselineOfJupyterTalk >> getKernelFileReference [
	"Obtain a suitable location to store the kernel.json file, and answer a <FileReference> to it.
	If a previous IPharo kernel directory and file was created, try to reuse that one.
	Otherwise, create a new directory under the workingDirectory (to avoid permission issues using root /) and create kernel.json"

	| kernelPath kernelsDir fileRef |

	OSSUnixSubprocess new
		command: 'jupyter';
		arguments: #('kernelspec' 'list');
		redirectStdout;
		runAndWaitOnExitDo: [ :process :outString  | kernelPath := self parseKernelPath: outString ].
	
	kernelsDir := kernelPath 
		ifEmpty: [ (FileSystem workingDirectory / self defaultKernelPathname) ensureCreateDirectory ]
		ifNotEmpty: [ kernelPath ].

	(fileRef := kernelsDir asFileReference / 'kernel.json' ) exists
		ifTrue: [ 
			Smalltalk tools workspace openContents: fileRef contents.
			(UIManager default confirm: 'An existing kernel.json for IPharo was detected,
 do you want to overwrite it with a new one?')
				ifTrue: [
					fileRef ensureDelete.
					fileRef := (kernelsDir asFileReference / 'kernel.json') ensureCreateFile ] ]
		ifFalse: [ fileRef := fileRef ensureCreateFile ].
	^ fileRef
]

{ #category : #protocol }
BaselineOfJupyterTalk >> groups: spec [
	spec 
		group: 'default' with: #('JupyterTalk');
		group: 'zmq' with: #('ZeroMQ');
		group: 'roassalSupport' with: #('JupyterTalk-Roassal');
		group: 'all' with: #('JupyterTalk-Roassal')
]

{ #category : #baselines }
BaselineOfJupyterTalk >> installDependencies: spec [

	spec
		baseline: 'SCouchDB'	
		with: [ 
			spec 
				repository: 'github://jmari/SCouchDB/repository';		
				loads:'json' ];
		"OSSubprocess does not support Windows"
		baseline: 'OSSubprocess' 
		with: [ 
			spec 
				repository: 'github://pharo-contributions/OSSubprocess:master/repository';
				loads: 'all' ].

]

{ #category : #private }
BaselineOfJupyterTalk >> installRoassal [
	"ROASSAL 3 is not supported"

	(Smalltalk includesKey: #RTBuilder)
		ifFalse: [
			(UIManager default questionWithoutCancel: 'Roassal 2 is required, do you want to install Roassal 2 in your Image?')
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

{ #category : #private }
BaselineOfJupyterTalk >> kernelNames [

	^ #('bash' 'ir' 'julia' 'octave' 'python' 'sagemath')
]

{ #category : #private }
BaselineOfJupyterTalk >> parseGenericKernelPathCandidates: aCollection [
	"Answer a <String> with the first path which does not look like a standard kernel for other programming languages than Pharo.
	If none, answer an empty <Collection>"

	aCollection pairsDo: [ : kernelName : kernelPath |
		(self kernelNames includes: kernelName) 
			ifFalse: [ ^ kernelPath ] ].
	^ String empty
]

{ #category : #private }
BaselineOfJupyterTalk >> parseKernelPath: outString [ 
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
BaselineOfJupyterTalk >> parsePharoKernelPathCandidates: aCollection [ 
	"Answer a <String> with a suitable location where to store the kernel.json file for IPharo, or empty if not found"

	^ aCollection 
		detect: [ : locationSpecArray | 
			| specName |
			specName := locationSpecArray first asLowercase.
			(specName beginsWith: 'pharo') or: [ specName endsWith: 'pharo' ]  ]
		ifFound: [ : found | found second ]
		ifNone: [ self parseGenericKernelPathCandidates: aCollection ]
]

{ #category : #baselines }
BaselineOfJupyterTalk >> postLoadIt [

	Smalltalk os isWindows 
		ifFalse: [ self createKernelFile ]
		ifTrue: [ Smalltalk tools workspace openContents: self windowsUnsupportedSteps  ]
]

{ #category : #private }
BaselineOfJupyterTalk >> windowsUnsupportedSteps [

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
