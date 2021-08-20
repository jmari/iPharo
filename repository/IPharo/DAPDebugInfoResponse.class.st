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
        'hashMethod' -> 'Murmur3'.
        'hashSeed' -> 'Pharo'.
        'tmpFilePrefix' -> 'ipharo'.
        'tmpFileSuffix' -> 'dbg'.
        'breakpoints' -> {    "breakpoints currently registered in the debugger"
            "{  
                'source' ->'',  source file
                'breakpoints' -> {}.  list of breakpoints for that source file
            } asDictionary "
        },
        'stoppedThreads' -> {},  "threads in which the debugger is currently in a stopped state (int)"
        'richRendering' -> true. " whether the debugger supports rich rendering of variables"
        'exceptionPaths' -> {}. "exception names used to match leaves or nodes in a tree of exception"
    } asDictionary 

]
