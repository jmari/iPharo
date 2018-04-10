initialization
initialize
"by now we need to stop the kernel each time the image is stopped or saved"
	Smalltalk addToShutDownList:  self.
"build a link in your image/Pluggings folder to"
	'libzmq.dylib'.
"create folder"
	'/usr/local/share/jupyter/kernels/pharo'.
"create file"
	'kernel.json'.
"with contents"
'{
  "argv": [
    "/Applications/Pharo6.1-64_ZeroMQ.app/Contents/MacOS/Pharo",
    "/Applications/Pharo6.1-64_ZeroMQ.app/Contents/Resources/Pharo6.1-64.image",
    "ipharo",
    "{connection_file}"
  ],
  "display_name": "Pharo Smalltalk",
  "language": "smalltalk"
}'
"copy an icon with file name logo-64x64.png"