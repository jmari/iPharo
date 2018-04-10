as yet unclassified
importRoassalJS: fileName
	"
	self importRoassalJS: 'roassal.js'
	"
	
	| content code |
	content := ((fileName asFileReference readStream contents copyReplaceAll: '''' with: '"')
		copyReplaceAll: String cr
		with: '') copyReplaceAll: String lf with: String cr.
	code := 'roassalJSContent
	^ ''' , content , ''''.
	self compile: code classified: 'dependencies'.
	TRPlatform current inform: 'imported roassal.js!!'