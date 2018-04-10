accessing
jupyterData
	^ jupyterData ifNil:[
		jupyterData := SCJsonObject new.
		jupyterData at:#data put:SCJsonObject new.
		jupyterData].