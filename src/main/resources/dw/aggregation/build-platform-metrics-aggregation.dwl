%dw 2.0
output application/json
var environments = vars.environments
var cloudHubApps = payload[0].payload.payload
var exchangeAssets = payload[1].payload
var apiManagerApis = payload[2].payload.payload
var members = payload[3].payload[0].payload
var usage = payload[3].payload[1].payload
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

var securePolicies=["client-id-enforcement","ip-","oauth","jwt-validation","authentication"]
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
				apisWithPolicies: sizeOf(flatten(getProdDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) > 0)] default []),
				apisWithoutPolicies: sizeOf(flatten(getProdDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) == 0)] default []),
				apisWithSecurity: sizeOf((flatten((flatten(getProdDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []),
				apisWithoutSecurity: sizeOf(flatten(getProdDetails(apiManagerApis) default [])) - sizeOf((flatten((flatten(getProdDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []), 
				apisWithContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(prodApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				contracts: sum(prodApiInstances.activeContractsCount default []),
				policiesUsed: flatten(flatten(getProdDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default [],
				policiesUsedTotal: sizeOf(flatten(flatten(getProdDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default []),
				automatedPoliciesUsed: flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				transactions: sum(flatten(flatten(getProdData(analyticsQueryResult).response default [])."api_id" default [])..count default []) //last x days on the period collected
			
			},
			sandbox: {
				total: sum(sandboxApis.total default []),
				active: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
				inactive: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
				apiInstances: sum(flatten(sandboxApis.assets).totalApis default []), 
				apiVersions: sizeOf(sandboxApiInstances.productVersion distinctBy $ default []),
				apisWithPolicies: sizeOf(flatten(getSandboxDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) > 0)] default []),
				apisWithoutPolicies: sizeOf(flatten(getSandboxDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) == 0)] default []),
				apisWithSecurity: sizeOf((flatten((flatten(getSandboxDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []),
				apisWithoutSecurity: sizeOf(flatten(getSandboxDetails(apiManagerApis) default [])) - sizeOf((flatten((flatten(getSandboxDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []), 
				apisWithContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				policiesUsed: flatten(flatten(getSandboxDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default [],
				policiesUsedTotal: sizeOf(flatten(flatten(getSandboxDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default []),
				automatedPoliciesUsed: flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				contracts: sum(sandboxApiInstances.activeContractsCount default []),
				transactions: sum(flatten(flatten(getSandboxData(analyticsQueryResult).response default [])."api_id" default [])..count default []) //last x days on the period collected
			}	
		}	
	},
	runtimeManagerMetrics: {
		cloudhub: {
			networking: {
				vpcsTotal: vars.entitlements.vpcs.assigned,
				vpcsAvailable: vars.entitlements.vpcs.assigned - usage.vpcsConsumed,
				vpcsUsed: usage.vpcsConsumed,
				vpnsTotal: vars.entitlements.vpns.assigned,
				vpnsAvailable: vars.entitlements.vpns.assigned - usage.vpnsConsumed,
				vpnsUsed: usage.vpnsConsumed
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
		
	},
	errors: vars.errors	
}
