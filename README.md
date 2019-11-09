# JupyterTalk
Basic Pharo Smaltalk kernel for Jupyter. This project is implemented on Pharo 6.1 64 bits and test it on Ubuntu Linux and Mac Os X. 
It uses ZeroMQ ported from <a href="http://smalltalkhub.com/#!/~panuw/zeromq">zeromq</a> project to uFFI.
Roassal integration supported. Main branch in this repository is in active development.
TO-DO:

- Tests...
- Improve ZeroMQ API.
- Installation procedure.


This project is also hosted in Smalltalkhub repository <a href="http://smalltalkhub.com/#!/~jmari/JupyterTalk">JupyterTalk</a><br/>
There you are a few examples on using jupiterTalk.
 - <a href="https://rawcdn.githack.com/jmari/JupyterTalk/master/Tutorial1_BasicStatistics.html"> Tutorial  1 - basic statistics</a>
  - <a href="http://htmlpreview.github.com/?https://github.com/jmari/JupyterTalk/blob/master/tensorflow.html"> Tutorial 2 - tensorflow </a>
   - <a href="http://htmlpreview.github.com/?https://github.com/jmari/JupyterTalk/blob/master/Tutorial4_Linear+Regression.html"> Tutorial 3 - Linear regression with tensorflow and polymath </a>
  
![JupyterTalk in Action](/jup3.png)

### install JupyterTalk
```Smalltalk
Metacello new 
	baseline: 'JupyterTalk';
	repository: 'github://jmari/JupyterTalk:master/repository';
	load:'all'
```
Create the folder	'/usr/local/share/jupyter/kernels/pharo'. Create file	'kernel.json' with contents
```JSON
'{
  "argv": [
    "/Path/To/Your/vm/Pharo",
    "/Path/to/your/image/Pharo6.1-64.image",
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
