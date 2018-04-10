private-message handling
messageContent: aZmqApiMessage
	| externalData size array|
	externalData := self apiZmqMsgData: aZmqApiMessage.
	size := self apiZmqMsgSize: aZmqApiMessage.
	array := ByteArray new: size.

	1 to: size do: [:i|
		array at: i put: (externalData getHandle unsignedByteAt: i).
	].
	^array.