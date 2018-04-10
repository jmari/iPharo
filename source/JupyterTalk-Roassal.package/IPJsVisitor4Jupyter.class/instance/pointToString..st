helpers
pointToString: point
	^ '{x:', (self number: point x), ',y:', (self number: point y),'}'