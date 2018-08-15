as yet unclassified
allMessageSelectors

	^ Object withAllSubclasses flatCollect: [ :cls |
    cls selectors select: [ :sel|
        (messagePart, '*' )  match: sel 
    ]].
