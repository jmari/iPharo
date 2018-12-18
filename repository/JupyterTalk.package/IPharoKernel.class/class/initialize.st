initialization
initialize
"by now we need to stop the kernel each time the image is stopped or saved"
	SessionManager default registerUserClassNamed: self name  atPriority: 100.
self flag: #todo.
"installation script"

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
}'.
"copy an icon with file name logo-64x64.png in the same folder"

'jupyter kernelspec install /path/to/kernel.json'