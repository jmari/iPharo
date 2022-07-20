Class {
	#name : #ManifestIPharoKernelProxy,
	#superclass : #PackageManifest,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'code-critics' }
ManifestIPharoKernelProxy class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#IPKernelProxyTest #testExecuteRequest #false)) #'2022-06-06T20:03:04.551239+02:00') )
]

{ #category : #'code-critics' }
ManifestIPharoKernelProxy class >> ruleSelfSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#IPConnectionConfig #initialize #false)) #'2022-04-10T16:57:14.235371+02:00') )
]
