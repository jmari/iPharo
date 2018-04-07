# JupyterTalk
Basic Pharo Smaltalk kernel for Jupyter. This project is implemented on Pharo 6.1 64 bits and Mac Os X. 
It uses ZeroMQ ported from <a href="http://smalltalkhub.com/#!/~panuw/zeromq"></a> project to uFFI.
Roassal integration supported.
TO-DO:
- Improve ZeroMQ API.
- Review display API.
- Widgets support.
- Installation procedure.
- 32 bits version? ZMQ is 64 a bits library on Mac Os.
- Tests...

This project is hosted in Smalltalkhub repository <a href="http://smalltalkhub.com/#!/~jmari/JupyterTalk"></a> because OSSubprocess/GitFileTree doesn't work on Pharo 64 bits.
![JupyterTalk in Action](/jup3.png)

### install JupyterTalk
```Smalltalk
Metacello new 
	baseline: 'JupyterTalk';
	repository: 'http://smalltalkhub.com/mc/jmari/JupyterTalk/main';
	load:'all'
```
Create the folder	'/usr/local/share/jupyter/kernels/pharo'. Create file	'kernel.json' with contents
```JSON
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
```
Optional, copy an icon with file name logo-64x64.png.

![Starting JupyterTalk](/jup1.png)
![JupyterTalk in Action](/jup2.png)
