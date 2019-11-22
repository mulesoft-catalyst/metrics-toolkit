%dw 2.0
output application/json

var environments = vars.environments
var apiManagerApis = payload[0].payload.payload
var cloudHubApps = payload[1].payload.payload
var armApps = payload[2].payload.payload

fun getProdData(arr) = (arr filter($.isProduction)).data

var prodApis=getProdData(apiManagerApis)
var prodApiInstances=flatten(flatten(prodApis.assets).apis default [])

var platformMetrics = {
	apisWithMoreThanOneConsumer: sizeOf(prodApiInstances.activeContractsCount filter ($ > 1) default []),
	apisWithOneOrMoreConsumers: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
	cloudHubApplicationsStarted: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status == "STARTED") default []),
	rtfApplicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
	hybridApplicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default [])
}

var totalApisReuse = platformMetrics.apisWithMoreThanOneConsumer
var totalApps = platformMetrics.cloudHubApplicationsStarted + platformMetrics.rtfApplicationsStarted + platformMetrics.hybridApplicationsStarted
var inputs=vars.benefitsInputs 

var developerProductivity = (inputs.developAPIHistoricTime/inputs.developAPICurrentTime) * 100
var savingFromAPIReuse = totalApisReuse * inputs.developAPIHistoricTime * inputs.developerDayRate 
var savingFromMaintenanceProductivity = (inputs.maintainAPIHistoricTime - inputs.maintainAPICurrentTime) * totalApps * inputs.developerDayRate 
var savingFromReuseInMaintenance = totalApisReuse * inputs.maintainAPIHistoricTime * inputs.developerDayRate
---
{
	date: vars.date,
	businessGroup: vars.orgName,
	developerProductivity: developerProductivity, 
	savingFromAPIReuse: savingFromAPIReuse, 
	savingFromMaintenanceProductivity: savingFromMaintenanceProductivity, 
	savingFromReuseInMaintenance: savingFromReuseInMaintenance, 
	totalSavings: savingFromAPIReuse + savingFromMaintenanceProductivity + savingFromReuseInMaintenance,
	errors: vars.errors
}