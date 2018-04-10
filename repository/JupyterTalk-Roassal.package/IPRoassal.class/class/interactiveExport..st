public
interactiveExport: view
	| filename |
	filename := TRPlatform current
		dialogRequestSaveFilename: 'Export as html'
		extensions: #('html')
		path: nil.
	filename
		ifNil: [
			TRPlatform current inform: 'Saving cancelled'.
			^ self].
	(self new)
		directory: filename parent;
		fileName: filename basename;
		export: view.
	TRPlatform current openFile: filename