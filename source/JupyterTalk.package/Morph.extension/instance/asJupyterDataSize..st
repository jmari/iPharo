*JupyterTalk-Core
asJupyterDataSize: size
	^ 'image/png' -> (self asBase64PNGSize:size  )