accessing platform
unix64ModuleName
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*"

	"On different flavors of linux the path to library may differ
	depending on OS distro or whether system is 32 or 64 bit.
	Packages such as snapcraft can also change the path.
	Look in a number of known locations, or LD_LIBRARY_PATH."

	| libNames |
	(#('/lib/x86_64-linux-gnu' '/usr/lib'),
			(((OSEnvironment current getEnv: 'LD_LIBRARY_PATH') ifNil: [ '' ]) substrings: ':'))
		do: [ :path | 
			| libraryPath |
			libNames:= (path asFileReference allChildren select:[:each| each basename beginsWith:'libzmq.so']). 
			
			libraryPath := path asFileReference / (libNames size>0) ifTrue:[libNames first] ifFalse:['libzmq.so'].
			libraryPath exists
				ifTrue: [ ^ libraryPath fullName ] ].
	self error: 'Cannot locate ZeroMQ library (libzmp.so). Please check if it installed on your system'
