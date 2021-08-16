"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIPharo,
	#superclass : #PackageManifest,
	#category : #'IPharo-Manifest'
}

{ #category : #'code-critics' }
ManifestIPharo class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#IPDisplay #refresh: #false)) #'2021-08-15T09:02:38.196553+02:00') )
]

{ #category : #'code-critics' }
ManifestIPharo class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#IPDisplay #openInJupyter: #false)) #'2021-08-14T16:31:49.866255+02:00') )
]
