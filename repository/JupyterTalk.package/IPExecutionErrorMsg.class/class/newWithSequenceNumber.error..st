instance creation
newWithSequenceNumber: aSeqNum error: AnException
	^ self basicNew 
				executionCount: aSeqNum;
				exceptionObject: AnException;
				initialize
				