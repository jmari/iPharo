Class {
	#name : #DAPDebugInfoResponse,
	#superclass : #DAPResponse,
	#category : #'IPharo-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDebugInfoResponse >> initialize [ 
	super initialize.
	self body: 
	{
        'isStarted' -> true.  " whether the debugger is started"
        'hashMethod' -> 'Murmur2'.
        'hashSeed' -> 0.
        'tmpFilePrefix' -> '/tmp/'.
        'tmpFileSuffix' -> '.st'.
        'breakpoints' -> {    "breakpoints currently registered in the debugger"
            "{  
                'source' ->'',  source file
                'breakpoints' -> {}.  list of breakpoints for that source file
            } asDictionary "
        }.
        'stoppedThreads' -> {}.  "threads in which the debugger is currently in a stopped state (int)"
      } asDictionary 

]
