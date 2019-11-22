%dw 2.0
output application/java
var strategy = p('loader.strategy')
---
{
	strategy: strategy,
	rawData: p('aggregation.raw'),
	(strategy match {
  		case "splunk" -> splunk: {
  			host: p('splunk.host'),
			port: p('splunk.port'),
			protocol: p('splunk.protocol'),
			token: p('splunk.token'),
			platformMetricsIndex: p('splunk.index.metrics'),
			platformBenefitsIndex: p('splunk.index.benefits'),
			source: p('splunk.source'),
			sourceType: p('splunk.source.type')
  		}
  		case "tableau" -> tableau: {
  			path: p('tableau.path')
  		}
  		else -> {}
	})
}