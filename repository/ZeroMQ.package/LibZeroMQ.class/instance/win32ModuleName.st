accessing platform
win32ModuleName
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
 