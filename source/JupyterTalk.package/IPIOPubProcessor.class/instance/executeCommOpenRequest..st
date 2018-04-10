running
executeCommOpenRequest: aMessage
	
	IPharoKernel instance commChanels at: aMessage content commID put:aMessage content.
	
	"NO-RESPONSE"