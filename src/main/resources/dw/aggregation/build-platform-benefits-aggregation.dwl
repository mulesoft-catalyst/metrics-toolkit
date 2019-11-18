%dw 2.0
output application/json


var totalApisReuse = payload.apisWithMoreThanOneConsumer
var totalApps = payload.cloudHubApplicationsStarted + payload.rtfApplicationsStarted + payload.hybridApplicationsStarted
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
	totalSavings: savingFromAPIReuse + savingFromMaintenanceProductivity + savingFromReuseInMaintenance
}