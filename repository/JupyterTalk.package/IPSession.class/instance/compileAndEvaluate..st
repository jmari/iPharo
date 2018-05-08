compilation
compileAndEvaluate: aMessage

	| result rcvr ctxt source|
	
	self resetJupyterData.
	rcvr := self doItReceiver.
	ctxt := self doItContext. 
	source := aMessage content code.

	[
	[result := rcvr class compiler
			source: source;
			context: ctxt;
			receiver: rcvr;
			requestor: self;
			failBlock:  [:err| ZmqLog logError:err msg . ^ nil];
			evaluate] on:Exception do:[:e| 
				"I don't know if it is a bug in opal compiler or what
				semantic analyzer doesn't know anything about workspace variables, compiling a block inside the compile process... 
				by now it's solved in that way"
				(e isKindOf: OCUndeclaredVariableWarning  ) ifTrue:[ e resume: (OCUndeclaredVariable new name: e node name) ].
				result := e.
			] ] forkAndWait.		

	(result isKindOf: Exception ) ifTrue:[ result signal].
	^  self jupyterData 
			
	