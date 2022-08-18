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
			token: p('secure::splunk.token'),
			platformMetricsIndex: p('splunk.index.metrics'),
			platformBenefitsIndex: p('splunk.index.benefits'),
			source: p('splunk.source'),
			sourceType: p('splunk.source.type')
  		}
  		case "tableau" -> tableau: {
  			outputDir: p('tableau.outputDir')
  		}
  		case "elk" -> elk: {
  			host: p('elk.host'),
  			port: p('elk.port'),
  			user: p('secure::elk.user'),
  			password: p('secure::elk.password'),
  			platformMetricsIndex: p('elk.index.metrics'),
			platformBenefitsIndex: p('elk.index.benefits'),		
  		}
  		case "sfdc" -> sfdc: {
  			username: p('secure::sfdc.username'),
  			password: p('secure::sfdc.password'),
  			securityToken: p('secure::sfdc.securityToken'),
  			authUrl: p('sfdc.authUrl') default "https://login.salesforce.com/services/Soap/u/50.0",
  			dataSetName: p('sfdc.dataSetName'),
  			appName: p('sfdc.appName'),
			sendNotification: p('sfdc.sendNotification'),		
			notificationEmail: p('sfdc.notificationEmail')
  		}
  		else -> {}
	})
}