%dw 2.0
output application/json
---
{
	loaderDetails: {
		strategy: 'splunk',
		rawData: "false",
		splunk: {
			host: "https://mysplunk.com",
			port: "8088",
			protocol: "HTTPS",
			token: "123",
			platformMetricsIndex: "metrics",
			platformBenefitsIndex: "platform_benefits",
			source: "metrics_source",
			sourceType: "_json"
		}	
	}
}