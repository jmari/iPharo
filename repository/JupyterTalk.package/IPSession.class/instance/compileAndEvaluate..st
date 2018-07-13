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
			evaluate] on:Error do:[:e| 
				"We just need to chech for Error not Exception"
				result := e.
			] ] forkAndWait.		
		
	(result isKindOf: Error ) ifTrue:[ 
		result signal].
	^  self jupyterData 
			
	