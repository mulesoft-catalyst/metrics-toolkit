%dw 2.0
output application/json
var environments = vars.environments
var entitlements = vars.entitlements
var errors = vars.errors

var date = vars.date
var orgName = vars.orgName
var orgId = vars.orgId

var cloudHubApps = payload[0].payload.payload
var exchangeAssets = payload[1].payload
var apiManagerApis = payload[2].payload.payload
var members = payload[3].payload[0].payload
var rolegroups = payload[3].payload[2].payload.data
var usage = payload[3].payload[1].payload
var designCenterProjects = payload[4].payload
var apiClients = payload[5].payload.applications
var apiAutomatedPolicies = payload[6].payload.payload
var armDeployments = payload[7].payload[0].payload.payload
var armServers = payload[7].payload[1].payload.payload
var armClusters = payload[7].payload[2].payload.payload
var armServerGroups = payload[7].payload[3].payload.payload
var armApps = payload[7].payload[4].payload.payload
var rtf = payload[8].payload
var analyticsQueryResult = payload[9].payload.payload
var mq = payload[10].payload.payload
---
{
	date: date,
	businessGroup: orgName,
	businessGroupId: orgId,
	coreServicesData: {
		entitlements: entitlements,
		users: members.data,
		rolegroups: rolegroups,
		usage: usage,
		environments: environments
	},
	designCenterData: designCenterProjects,
	exchangeData: exchangeAssets,
	apiManagerData: {
		clients: apiClients,
		apis: apiManagerApis,
		apiAutomatedPolicies: apiAutomatedPolicies,
		anaytics: analyticsQueryResult
	},
	runtimeManagerData: {
		cloudHubApps: cloudHubApps,
		rtf: rtf,
		armDeployments: armDeployments,
		armApps: armApps,
		armServers: armServers,
		armClusters: armClusters,
		armServerGroups: armServerGroups
	},
	mqMetrics: mq,
	errors: errors		
}
