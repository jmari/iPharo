initialization
initialize
	super initialize.
	self msgType: #kernel_info_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: { 
						#protocol_version -> IPharoKernel protocolVersion.
						#implementation -> IPharoKernel implementation.
						#implementation_version -> IPharoKernel version.
						#language_info ->{
							#name-> #Smalltalk.
							#version -> SystemVersion current dottedMajorMinor.
							#mimetype -> 'text/plain'.
							#file_extension -> 'st'.
							} asSCJsonObject .
						#banner -> 'Pharo Smalltalk'.
						#HelpLinks -> {{#Text-> 'Pharo Smaltalk'. 
											 #URL-> 'https://pharo.org/'} asSCJsonObject} asSCJsonObject  
						} asSCJsonObject 