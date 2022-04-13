Class {
	#name : #ManifestIPharoKernelProxy,
	#superclass : #PackageManifest,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'code-critics' }
ManifestIPharoKernelProxy class >> ruleSelfSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#IPConnectionConfig #initialize #false)) #'2022-04-10T16:57:14.235371+02:00') )
]
