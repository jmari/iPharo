# JupyterTalk and ZeroMQ 
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jmari/JupyterTalk.git/master?filepath=notebooks/Tutorial1_BasicStatistics.ipynb)

 
Basic Pharo Smaltalk kernel for Jupyter. This project is implemented on Pharo 7/8 64 bits and test it on Ubuntu Linux and Mac Os X. 
It uses ZeroMQ ported from <a href="http://smalltalkhub.com/#!/~panuw/zeromq">zeromq</a> project to uFFI.
Roassal integration supported. Main branch in this repository is in active development.
TO-DO:

- Tests...
- Improve ZeroMQ API.
- Installation procedure.

There you are a few examples on using jupiterTalk, you can test some of them in Binder.
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/Tutorial1_BasicStatistics.html"> Tutorial  1 - basic statistics</a>
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/tensorflow.html"> Tutorial 2 - tensorflow </a>
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/Tutorial4_Linear+Regression.html"> Tutorial 3 - Linear regression with tensorflow and polymath </a>
  

![JupyterTalk in Action](/img/jup3.png)

### install JupyterTalk
Install Jupyter notebooks, I suggest you to install Anaconda package. Once you have Jupyter installed, load JupyterTalk in a fresh Pharo image.
```Smalltalk
Metacello new 
	baseline: 'JupyterTalk';
	repository: 'github://jmari/JupyterTalk:master/repository';
	load:'all'
```

If you are only interested in ZeroMQ Binding, please do:
```Smalltalk
Metacello new 
	baseline: 'JupyterTalk';
	repository: 'github://jmari/JupyterTalk:master/repository';
	load:'zmq'
```
Kernel.json file should be created by Metacello (in Mac or Linux) in the correct place. If you are not able to star a new notebook in Pharo Smalltalk language, create this file manually.
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

![Starting JupyterTalk](/img/jup1.png)
![JupyterTalk in Action](/img/jup2.png)
