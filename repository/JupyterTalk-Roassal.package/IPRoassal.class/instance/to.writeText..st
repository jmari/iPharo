helpers
to: outputStream writeText: text
	outputStream nextPutAll: (text copyReplaceAll: String cr with: String crlf)