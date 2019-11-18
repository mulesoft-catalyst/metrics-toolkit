%dw 2.0
output application/json

var environments = vars.environments
var apiManagerApis = payload[0].payload.payload
var cloudHubApps = payload[1].payload.payload
var armApps = payload[2].payload.payload


fun getProdData(arr) = (arr filter($.isProduction)).data

var prodApis=getProdData(apiManagerApis)
var prodApiInstances=flatten(flatten(prodApis.assets).apis default [])

---
{
	date: vars.date,
	businessGroup: vars.orgName,
	apisWithMoreThanOneConsumer: sizeOf(prodApiInstances.activeContractsCount filter ($ > 1) default []),
	apisWithOneOrMoreConsumers: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
	cloudHubApplicationsStarted: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status == "STARTED") default []),
	rtfApplicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
	hybridApplicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default [])
}
