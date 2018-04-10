accessing
title
	^ title ifNil: [ title := self defaultTitle ]