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
var armApps = payload[7].payload.payload
var armServers = payload[8].payload.payload
var armClusters = payload[9].payload.payload
var armServerGroups = payload[10].payload.payload
var analyticsQueryResult = payload[11].payload.payload

fun getProdData(arr) = (arr filter($.isProduction)).data
fun getSandboxData(arr) = (arr filter(not $.isProduction)).data

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
		flowDesignerApps: "NA"
	},
	exchangeMetrics: {
		total: sizeOf(exchangeAssets default []) + sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		apiSpecs: sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		connectors: sizeOf(exchangeAssets filter($."type" == "rest-api") default []),
		fragments: sizeOf(exchangeAssets filter($."type" == "raml-fragment") default []),
		proxies: sizeOf(exchangeAssets filter($."type" == "http-api") default []),
		extensions: sizeOf(exchangeAssets filter($."type" == "extension") default []),
		custom: sizeOf(exchangeAssets filter($."type" == "custom") default [])	,
		overallSatisfaction: "NA"			
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
				vpcsTotal: "NA",
				vpcsAvailable: "NA",
				vpcsUsed: "NA",
				vpnsTotal: "NA",
				vpnsAvailable: "NA",
				vpnsUsed: "NA"
			},
			applications:{
				production: {
					vcoresTotal: vars.entitlements.vCoresProduction.assigned,
					vcoresAvailable: (vars.entitlements.vCoresProduction.assigned as Number) - sum(flatten((cloudHubApps filter ($.isProduction)).data default []) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum(flatten((cloudHubApps filter ($.isProduction)).data default []) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten((cloudHubApps filter ($.isProduction)).data default []) default []),
					applicationsStarted: sizeOf(flatten((cloudHubApps filter ($.isProduction)).data default []) filter ($.status == "STARTED") default []),
					applicationsStopped: sizeOf(flatten((cloudHubApps filter ($.isProduction)).data default []) filter ($.status != "STARTED") default []),
					runtimesUsed: flatten((cloudHubApps filter ($.isProduction)).data default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten((cloudHubApps filter ($.isProduction)).data default []).muleVersion.version distinctBy ($) default [])
				},
				sandbox:{
					vcoresTotal: vars.entitlements.vCoresSandbox.assigned,
					vcoresAvailable: (vars.entitlements.vCoresSandbox.assigned as Number) - sum(flatten((cloudHubApps filter (not $.isProduction)).data default []) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum(flatten((cloudHubApps filter (not $.isProduction)).data default []) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten((cloudHubApps filter (not $.isProduction)).data default []) default []),
					applicationsStarted: sizeOf(flatten((cloudHubApps filter (not $.isProduction)).data default []) filter ($.status == "STARTED") default []),
					applicationsStopped: sizeOf(flatten((cloudHubApps filter (not $.isProduction)).data default []) filter ($.status != "STARTED") default []),
					runtimesUsed: flatten((cloudHubApps filter (not $.isProduction)).data default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten((cloudHubApps filter (not $.isProduction)).data default []).muleVersion.version distinctBy ($) default [])
				}
			}
		},
		rtf: {
			production: {
				fabrics: "NA",
				coresTotal: "NA",
				coresAvailable: "NA", //cores
				coresUsed: "NA", //cores
				memoryTotal: "NA",
				memoryAvailable: "NA", //Gigs
				memoryUsed: "NA", //Gigs
				applicationsTotal: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'MC') default []),
				applicationsStarted: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
				applicationsStopped: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'MC') default [] filter ($.application.status != 'RUNNING') default []),
				runtimesUsed: ["NA"],
				runtimesUsedTotal: "NA"
			},
			sandbox:{
				fabrics: "NA",
				coresTotal: "NA",
				coresAvailable: "NA", //cores
				coresUsed: "NA", //cores
				memoryTotal: "NA",
				memoryAvailable: "NA", //Gigs
				memoryUsed: "NA", //Gigs
				applicationsTotal: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'MC') default []),
				applicationsStarted: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'MC') default [] filter ($.application.status == 'RUNNING') default []),
				applicationsStopped: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'MC') default [] filter ($.applcation.status != 'RUNNING') default []),
				runtimesUsed: ["NA"],
				runtimesUsedTotal: "NA"
			}
		},
		hybrid: {
			production: {
				servers: sizeOf(flatten((armServers filter($.isProduction)).data.data default []) default []),
				clusters: sizeOf(flatten((armClusters filter($.isProduction)).data.data default []) default []),
				serverGroups: sizeOf(flatten((armServerGroups filter($.isProduction)).data.data default []) default []),
				applicationsTotal: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'RR') default []),
				applicationsStarted: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default []),
				applicationsStopped: sizeOf(flatten((armApps filter($.isProduction)).data.items default []) filter($.target.provider == 'RR') default [] filter ($.status != 'STARTED') default []),
				runtimesUsed: flatten((armServers filter($.isProduction)).data.data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten((armServers filter($.isProduction)).data.data default []).muleVersion distinctBy $ default [])
			},
			sandbox:{
				servers: sizeOf(flatten((armServers filter(not $.isProduction)).data.data default []) default []),
				clusters: sizeOf(flatten((armClusters filter(not $.isProduction)).data.data default []) default []),
				serverGroups: sizeOf(flatten((armServerGroups filter(not $.isProduction)).data.data default []) default []),
				applicationsTotal: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'RR') default []),
				applicationsStarted: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'RR') default [] filter ($.status == 'STARTED') default []),
				applicationsStopped: sizeOf(flatten((armApps filter(not $.isProduction)).data.items default []) filter($.target.provider == 'RR') default [] filter ($.status != 'STARTED') default []),
				runtimesUsed: flatten((armServers filter(not $.isProduction)).data.data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten((armServers filter(not $.isProduction)).data.data default []).muleVersion distinctBy $ default [])
			}
		}
		
	}	
}
