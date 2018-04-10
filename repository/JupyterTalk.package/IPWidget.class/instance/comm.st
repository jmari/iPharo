lifecycle
comm
       "Open a comm to the frontend if one isn't already open."    
		|args state buffer_paths buffers| 
   		"state, buffer_paths, buffers = _remove_buffers(self.get_state())"
     
		 args := { #target_name-> 'jupyter.widget'.
                #data-> {'state'-> state. 'buffer_paths'-> buffer_paths} asSCJsonObject.
   		                 #buffers->buffers.
     	                 #metadata>{'version'-> self protocolVersion} asSCJsonObject.
                      }.

        self model uuid ifNil:[args comm_id: self model uuid].
        comm := 	IPharoKernel instance commChanels at: self model uuid put: args.
            