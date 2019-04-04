Class {
	#name : #LibZeroMQ,
	#superclass : #FFILibrary,
	#category : 'ZeroMQ-Api'
}

{ #category : #'accessing platform' }
LibZeroMQ >> macModuleName [
	^ 'libzmq.dylib'
]

{ #category : #'accessing platform' }
LibZeroMQ >> unix64ModuleName [
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*"

	"On different flavors of linux the path to library may differ
	depending on OS distro or whether system is 32 or 64 bit.
	Packages such as snapcraft can also change the path.
	Look in a number of known locations, or LD_LIBRARY_PATH."

	| libNames libZmqPaths|
	libZmqPaths := {	((OSEnvironment current getEnv: 'HOME'),'/anaconda3/lib/').
							((OSEnvironment current getEnv: 'HOME'),'/anaconda2/lib/').
							'/usr/lib'.
							'/lib/x86_64-linux-gnu'.
							},
						(((OSEnvironment current 
												getEnv: 'LD_LIBRARY_PATH') 
												ifNil: [ '' ]) substrings: ':').
	libZmqPaths		
		do: [ :path | 
			| libraryPath fr|
			fr := path asFileReference.
			(fr exists and:[fr isReadable]) ifTrue:[ 
				libNames:= (fr childNames select:[:each| each  beginsWith:'libzmq.so']). 
				libraryPath := fr / ((libNames size>0) ifTrue:[libNames first] ifFalse:['libzmq.so']).
				libraryPath exists
					ifTrue: [ ^ libraryPath fullName ] ] ].
			
	self error: 'Cannot locate ZeroMQ library (libzmp.so). Please check if it installed on your system'

]

{ #category : #'accessing platform' }
LibZeroMQ >> unixModuleName [
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*"
	^ self unix64ModuleName 
]

{ #category : #'accessing platform' }
LibZeroMQ >> win32ModuleName [
| libNames libZmqPaths|
	libZmqPaths := (((OSEnvironment current 
												getEnv: 'PROGRAMFILES') 
												ifNil: [ '' ]) substrings: ';').
						(((OSEnvironment current 
												getEnv: 'PROGRAMFILES(X86)') 
												ifNil: [ '' ]) substrings: ';').
	libZmqPaths		
		do: [ :path | 
			| libraryPath fr|
			fr := path asFileReference.
			(fr exists and:[fr isReadable]) ifTrue:[ 
				libNames:= (fr childNames select:[:each| each  beginsWith:'ZeroMQ']). 
				
				libraryPath := fr / ((libNames size>0) ifTrue:[libNames first] ifFalse:['nothing']).
				libraryPath exists ifTrue:[libraryPath := libraryPath / 'bin'].
				libNames:=	libraryPath childNames select:[:each| each  beginsWith:'libzmq-v100'].
				libraryPath := libraryPath / ((libNames size>0) ifTrue:[libNames first ] ).
				
				libraryPath exists
					ifTrue: [ ^ libraryPath  fullName ] ] ].
			
	self error: 'Cannot locate ZeroMQ library (libzmp.so). Please check if it installed on your system'
 
]
