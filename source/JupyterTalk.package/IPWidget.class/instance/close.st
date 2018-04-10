lifecycle
close
       "Open a comm to the frontend if one isn't already open."

	IPharoKernel instance removeCommMsgHandlersForChanel: self comm.
	IPharoKernel instance commChanels removeKey: self comm ifAbsent:[].
            