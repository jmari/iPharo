visitor
visitAttachPoint: element trShape: shape
	self visitAttachPoint: element index: (element trachelShape shapes indexOf: shape)
	