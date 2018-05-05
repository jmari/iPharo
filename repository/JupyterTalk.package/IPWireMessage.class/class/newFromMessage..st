instance creation
newFromMessage: anIPMessage
	|instance serializer|
	serializer := SCSerializer new.
	instance := self new.
	"be sure message type is the correct msgType
	uuid is set in the IPMessageProcessor #execute: method"
	instance push: anIPMessage uuid asByteArray.
	instance push: 0.
	instance push: (serializer serialize: anIPMessage header) asByteArray.
	"parent_header must be exactly the same header, this won't be serialized/paterialized"
	instance push: anIPMessage parentHeader.
	instance push: (serializer serialize: anIPMessage metadata) asByteArray.
	instance push: (serializer serialize: anIPMessage content) utf8Encoded.
	instance hmac: instance calculateHMAC hex asByteArray.
	^instance