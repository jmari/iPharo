# iPharo and ZeroMQ 
[![Binder](https://mybinder.org/badge_logo.svg)](https://github.com/jmari/iPharoBinder)

 
Pharo Smaltalk kernel for Jupyter. This project is implemented on Pharo 9 64 bits and test it on Mac Os X. 
It uses ZeroMQ ported from <a href="http://smalltalkhub.com/#!/~panuw/zeromq">zeromq</a> project to uFFI.
Roassal 2 integration is supported. Main branch in this repository is in active development.

There you are a few examples on using iPharo, you can test some of them in Binder.
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/Tutorial1_BasicStatistics.html"> Tutorial  1 - basic statistics</a>
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/tensorflow.html"> Tutorial 2 - tensorflow </a>
  - <a href="http://rawcdn.githack.com/jmari/JupyterTalk/master/notebooks/Tutorial4_Linear+Regression.html"> Tutorial 3 - Linear regression with tensorflow and polymath </a>
  

![iPharo in Action](/img/jup3.png)

### install iPharo
First of all install Jupyter notebooks, I suggest you to install Anaconda package. Once you have Jupyter Notebooks installed, load iPharo in a fresh Pharo image.
```Smalltalk
Metacello new 
	baseline: 'IPharo';
	repository: 'github://jmari/IPharo:master/repository';
	load:'default'
```

Kernel.json file should be created by Metacello (in Mac or Linux) in the correct place. If you are not able to start a new notebook in Pharo Smalltalk language, create this file manually.
Create the folder	'/usr/local/share/jupyter/kernels/pharo'. Create file	'kernel.json' with contents
```JSON
{
  "argv": [
    "/Path/To/Your/vm/Pharo",
    "/Path/to/your/image/Pharo6.1-64.image",
    "ipharo",
    "{connection_file}"
  ],
  "display_name": "Pharo Smalltalk",
  "language": "smalltalk"
}
```
Optional, copy an icon with file name logo-64x64.png.

If you are only interested in ZeroMQ Binding, please do:
```Smalltalk
Metacello new 
	baseline: 'IPharo';
	repository: 'github://jmari/IPharo:master/repository';
	load:'zmq'
```

![Starting JupyterTalk](/img/jup1.png)
![JupyterTalk in Action](/img/jup2.png)
