instance creation
newWithSequenceNumber: aSeqNum
	^ self basicNew 
				executionCount: aSeqNum;
				initialize