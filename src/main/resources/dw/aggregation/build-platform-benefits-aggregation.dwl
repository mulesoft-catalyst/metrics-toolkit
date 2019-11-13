%dw 2.0
output application/json


var totalApisReuse = 5
var totalProxies = 10
var totalAPIs = 9
var totalIntegrations = 1
var totalApps = (totalProxies + totalAPIs + totalIntegrations)

var savingFromDeveloperProductivity= (attributes.queryParams.developAPIHistoricTime/attributes.queryParams.developAPICurrentTime) * 100
var savingFromAPIReuse = totalApisReuse * attributes.queryParams.developAPIHistoricTime * attributes.queryParams.developerDayRate 
var savingFromMaintenanceProductivity = (attributes.queryParams.maintainAPIHistoricTime - attributes.queryParams.maintainAPICurrentTime) * totalApps * attributes.queryParams.developerDayRate 
var savingFromReuseInMaintenance = totalApisReuse * attributes.queryParams.maintainAPIHistoricTime * attributes.queryParams.developerDayRate
var totalSavings = savingFromAPIReuse + savingFromMaintenanceProductivity + savingFromReuseInMaintenance
---
{
	savingFromDeveloperProductivity: savingFromDeveloperProductivity, 
	savingFromAPIReuse: savingFromAPIReuse, 
	savingFromMaintenanceProductivity: savingFromMaintenanceProductivity, 
	savingFromReuseInMaintenance: savingFromReuseInMaintenance, 
	totalSavings: totalSavings
}