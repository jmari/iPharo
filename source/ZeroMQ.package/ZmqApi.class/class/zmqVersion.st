public api
zmqVersion
	| major minor patch version |
	major := ZmqApiStructForInt externalNew.
	minor := ZmqApiStructForInt externalNew.
	patch := ZmqApiStructForInt externalNew.
	self apiZmqVersion:  major minor:  minor patch:  patch.
	version := ZmqVersion major: major value minor: minor value patch: patch value.
	^version.
