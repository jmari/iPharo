comm handlers
addCommMsgHandler: aTwoParamBlock toChanel:aChanelId
	self commMsgHandlers at:aChanelId put:aTwoParamBlock