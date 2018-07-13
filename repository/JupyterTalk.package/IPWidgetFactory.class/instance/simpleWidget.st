as yet unclassified
simpleWidget
	| comm wInstance |
	comm := IPComm new.
	wInstance := IPharoKernel instance commManager 
										instanceForTargetClass: 'jupyter.widget' 
										usingComm: comm.
	comm open: wInstance model.
	^ wInstance