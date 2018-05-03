*JupyterTalk-Core
asJupyterDataWithExtent: size
	^ 'image/png' -> (self asBase64PNGSize:size  )