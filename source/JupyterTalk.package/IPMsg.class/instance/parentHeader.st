accessing
parentHeader
	^ parentHeader ifNil:[parentHeader := SCJsonObject new asByteArray ]