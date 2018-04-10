instance creation
newFromWireMessage: aWireMessage
	| instance materializer |
	materializer := SCMaterializer new.
	instance := self new.
	instance header: ( materializer materialize: aWireMessage header asString).	
	instance parentHeader: (materializer materialize: aWireMessage parentHeader asString).
	instance metadata: ( materializer materialize: aWireMessage metadata asString).
	instance content: ( materializer materialize: aWireMessage content asString).
	instance msgId: (instance header ifNil:[nil] ifNotNil:[instance header msg_id]).
	instance msgType: (instance header ifNil:[nil] ifNotNil:[instance header msg_type]).
	^ instance