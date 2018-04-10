accessing
header
	^ header  ifNil:[header := {
                'msg_id' -> self msgUUID.
                'date' -> DateAndTime now asString. 
                'msg_type' -> self msgType.
                'version' -> '5.0'.
     } asSCJsonObject ]