comm handlers
instanceForTargetClass: targetClass usingComm: aCom
	| class |
	aCom targetName: targetClass.
	class := self targetClasses 
						at:targetClass 
						ifAbsentPut:[IPWidget].
	^ class new comm:aCom
