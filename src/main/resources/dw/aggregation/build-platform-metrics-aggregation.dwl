%dw 2.0
output application/json
var environments = vars.environments
var cloudHubApps = payload[0].payload.payload
var exchangeAssets = payload[1].payload
var apiManagerApis = payload[2].payload.payload
var members = payload[3].payload
var designCenterProjects = payload[4].payload
var apiClients = payload[5].payload.applications
var apiAutomatedPolicies = payload[6].payload.payload
var armApps = payload[7].payload[0].payload.payload
var armServers = payload[7].payload[1].payload.payload
var armClusters = payload[7].payload[2].payload.payload
var armServerGroups = payload[7].payload[3].payload.payload
var rtf = payload[8].payload
var analyticsQueryResult = payload[9].payload.payload

fun getProdData(arr) = (arr filter($.isProduction)).data
fun getSandboxData(arr) = (arr filter(not $.isProduction)).data

fun getProdDetails(arr) = (arr filter($.isProduction)).details
fun getSandboxDetails(arr) = (arr filter(not $.isProduction)).details

var prodApis=getProdData(apiManagerApis)
var prodApisAssets=prodApis.assets
var prodApiInstances=flatten(flatten(prodApisAssets).apis default [])

var sandboxApis=getSandboxData(apiManagerApis)
var sandboxApisAssets=sandboxApis.assets
var sandboxApiInstances=flatten(flatten(sandboxApisAssets).apis default [])

var analyticsEnrichedData = analyticsQueryResult map ((v,k) -> {
	environment: v.environment,
	apiIds: v.data.response[0]."api_id",
	clientIds: v.data.response[1]."client_id"
})
---
{
	date: vars.date,
	businessGroup: vars.orgName,
	coreServicesMetrics: {
		users: {
			total: sizeOf(members.data default []),
			activeMembers: sizeOf(members.data  filter ($.enabled == true) default []),
			inactiveMembers: sizeOf(members.data  filter ($.enabled == false) default []),
			activeMembersLast60Days: sizeOf(members.data filter ($.lastLogin  >= (now() - |P60D|)) default []),
			activeMembersLast30Days: sizeOf(members.data filter ($.lastLogin  >= (now() - |P30D|)) default []) 
		},
		environments: {
			total:  sizeOf(environments default []),
			production: sizeOf(environments  filter ($.isProduction) default []),
			sandbox: sizeOf(environments  filter (not $.isProduction) default []),
		}
	},
	designCenterMetrics: {
		total: sizeOf(designCenterProjects default []),
		apiSpecs: sizeOf(designCenterProjects filter($."type" == "raml") default []),
		fragments: sizeOf(designCenterProjects filter($."type" == "raml-fragment") default []),
		flowDesignerApps: sizeOf(designCenterProjects filter($."type" == "Mule_Application") default [])
	},
	exchangeMetrics: {
		total: sizeOf(exchangeAssets default []) + sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		apiSpecs: sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		connectors: sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		fragments: sizeOf(exchangeAssets filter($."type" == "raml-fragment") default []),
		proxies: sizeOf(exchangeAssets filter($."type" == "http-api") default []),
		extensions: sizeOf(exchangeAssets filter($."type" == "extension") default []),
		custom: sizeOf(exchangeAssets filter($."type" == "custom") default [])	,
		overallSatisfaction: if (sizeOf(exchangeAssets) > 0) (sum(exchangeAssets.rating default [])/sizeOf(exchangeAssets)) else 0		
	},
	apiManagerMetrics: {
		clients: sizeOf(apiClients default []),
		apis: {
			production: {
				total: sum(prodApis.total default []),
				active: if (not isEmpty(prodApiInstances.lastActiveDate)) sizeOf(prodApiInstances.lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
				inactive: if (not isEmpty(prodApiInstances.lastActiveDate)) sizeOf(prodApiInstances.lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
				apiInstances: sum(flatten(prodApis.assets).totalApis default []), 
				apiVersions: sizeOf(prodApiInstances.productVersion distinctBy $ default []),
				apisWithPolicies: "NA",
				apisWithoutPolicies: "NA",
				apisWithSecurity: "NA",
				apisWithoutSecurity:"NA", 
				apisWithContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(prodApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				contracts: sum(prodApiInstances.activeContractsCount default []),
				policiesUsed: flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [], // + Normal policies
				policiesUsedTotal: sizeOf(flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies distinctBy ($) default []).assetId default []), // + Normal policies
				automatedPoliciesUsed: flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				transactions: "NA" //last x days on the period collected
			
			},
			sandbox: {
				total: sum(sandboxApis.total default []),
				active: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
				inactive: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
				apiInstances: sum(flatten(sandboxApis.assets).totalApis default []), 
				apiVersions: sizeOf(sandboxApiInstances.productVersion distinctBy $ default []),
				apisWithPolicies: "NA",
				apisWithoutPolicies: "NA",
				apisWithSecurity: "NA",
				apisWithoutSecurity:"NA", 
				apisWithContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				policiesUsed: flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [], // + Normal policies
				policiesUsedTotal: sizeOf(flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []), // + Normal policies
				automatedPoliciesUsed: flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				contracts: sum(sandboxApiInstances.activeContractsCount default []),
				transactions: "NA" //last x days on the period collected
			}	
		}	
	},
	runtimeManagerMetrics: {
		cloudhub: {
			networking: {
				vpcsTotal: vars.entitlements.vpcs.assigned,
				vpcsAvailable: "NA",
				vpcsUsed: "NA",
				vpnsTotal: vars.entitlements.vpns.assigned,
				vpnsAvailable: "NA",
				vpnsUsed: "NA"
			},
			
			applications:{
				production: {
					vcoresTotal: vars.entitlements.vCoresProduction.assigned,
					vcoresAvailable: (vars.entitlements.vCoresProduction.assigned as Number) - sum(flatten(getProdData(cloudHubApps) default []) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum(flatten(getProdData(cloudHubApps) default []) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten(getProdData(cloudHubApps) default []) default []),
					applicationsStarted: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status == "STARTED") default []),
					applicationsStopped: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status != "STARTED") default []),
					runtimesUsed: flatten(getProdData(cloudHubApps) default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten(getProdData(cloudHubApps) default []).muleVersion.version distinctBy ($) default [])
				},
				sandbox:{
					vcoresTotal: vars.entitlements.vCoresSandbox.assigned,
					vcoresAvailable: (vars.entitlements.vCoresSandbox.assigned as Number) - sum(flatten(getSandboxData(cloudHubApps) default []) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum(flatten(getSandboxData(cloudHubApps) default []) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten(getSandboxData(cloudHubApps) default []) default []),
					applicationsStarted: sizeOf(flatten(getSandboxData(cloudHubApps) default []) filter ($.status == "STARTED") default []),
					applicationsStopped: sizeOf(flatten(getSandboxData(cloudHubApps) default []) filter ($.status != "STARTED") default []),
					runtimesUsed: flatten(getSandboxData(cloudHubApps) default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten(getSandboxData(cloudHubApps) default []).muleVersion.version distinctBy ($) default [])
				}
			}
		},
		rtf: {
			capacity: {
				fabrics: sizeOf(rtf),
    				workers: sizeOf((flatten(rtf.nodes) filter($.role == "worker") default []) default []),
    				controllers: sizeOf((flatten(rtf.nodes) filter($.role == "controller") default []) default []),
    				coresTotal: sum((flatten(rtf.nodes) filter($.role == "worker") default []).capacity.cpuMillis default [])/1000,
   				memoryTotal: sum((flatten(rtf.nodes) filter($.role == "worker") default []).capacity.memoryMi default [])/1000,
    				coresPerFabric: if (sizeOf(rtf) > 0) (sum((flatten(rtf.nodes) filter($.role == "worker") default []).capacity.cpuMillis default [])/(sizeOf(rtf) * 1000)) else 0,
    				memoryPerFabric: if (sizeOf(rtf) > 0) (sum((flatten(rtf.nodes) filter($.role == "worker") default []).capacity.memoryMi default [])/(sizeOf(rtf) * 1000)) else 0
			},
			applications: {
				production: {
					//coresAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					coresUsed: sum((flatten(getProdDetails(armApps) default []).target.deploymentSettings.resources.cpu.limit  map (($ replace  "m" with "") as Number)) default [])/1000, //cores
					//memoryAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					memoryUsed: sum((flatten(getProdDetails(armApps) default []).target.deploymentSettings.resources.memory.limit  map (($ replace  "Mi" with "") as Number)) default [])/1000, //Gigs
					applicationsTotal: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'MC') default []),
					applicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
					applicationsStopped: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.application.status != 'RUNNING') default []),
					runtimesUsed: flatten(getProdDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
					runtimesUsedTotal: sizeOf(flatten(getProdDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [])

					
				},
				sandbox:{
					//coresAvailable: "NA", //cores // Not able to calculate because a fabric can be associated with multiple environments of any type
					coresUsed: sum((flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.resources.cpu.limit  map (($ replace  "m" with "") as Number)) default [])/1000, //cores
					//memoryAvailable: "NA", //Gigs // Not able to calculate because a fabric can be associated with multiple environments of any type
					memoryUsed: sum((flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.resources.memory.limit  map (($ replace  "Mi" with "") as Number)) default [])/1000, //Gigs
					applicationsTotal: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'MC') default []),
					applicationsStarted: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
					applicationsStopped: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'MC') default [] filter ($.applcation.status != 'RUNNING') default []),
					runtimesUsed: flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
					runtimesUsedTotal: sizeOf(flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [])
				}	
			}
		},
		hybrid: {
			production: {
				servers: sizeOf(flatten(getProdData(armServers).data default []) default []),
				clusters: sizeOf(flatten(getProdData(armClusters).data default []) default []),
				serverGroups: sizeOf(flatten(getProdData(armServerGroups).data default []) default []),
				applicationsTotal: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'RR') default []),
				applicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default []),
				applicationsStopped: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status != 'STARTED') default []),
				runtimesUsed: flatten(getProdData(armServers).data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten(getProdData(armServers).data default []).muleVersion distinctBy $ default [])
			},
			sandbox:{
				servers: sizeOf(flatten(getSandboxData(armServers).data default []) default []),
				clusters: sizeOf(flatten(getSandboxData(armClusters).data default []) default []),
				serverGroups: sizeOf(flatten(getSandboxData(armServerGroups).data default []) default []),
				applicationsTotal: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'RR') default []),
				applicationsStarted: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default []),
				applicationsStopped: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == 'RR') default [] filter ($.status != 'STARTED') default []),
				runtimesUsed: flatten(getSandboxData(armServers).data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten(getSandboxData(armServers).data default []).muleVersion distinctBy $ default [])
			}
		}
		
	}	
}
