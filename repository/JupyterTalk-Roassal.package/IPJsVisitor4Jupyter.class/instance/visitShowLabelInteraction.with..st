visitor-interactions
visitShowLabelInteraction: anInt with: el
	
	stream nextPutAll: 'new RTShowLabel(['.
	((anInt highlightElements) rtValue: el) do: [:ele |
		(anInt labelledInteraction initializeElement: ele) accept: self.
	].
	stream nextPutAll: ']) '.
	anInt doUnhighlightElement: el