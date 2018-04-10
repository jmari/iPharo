as yet unclassified
calculateHMAC
	^ (HMAC on: SHA256)
			key: IPharoKernel instance sharedKey asByteArray ;
			digestMessage:
						self header,
						self parentHeader,
						self metadata,
						self content  