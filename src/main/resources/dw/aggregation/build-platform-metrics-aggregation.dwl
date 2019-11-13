%dw 2.0
output application/json
var environments = vars.environments
var cloudHubApps = payload[0].payload.payload
var exchangeAssets = payload[1].payload
var apiManagerApis = payload[2].payload.payload
var members = payload[3].payload
var designCenterProjects = payload[4].payload
var apiClients = payload[5].payload.applications
var analyticsQueryResult = payload[6].payload.payload

var analyticsEnrichedData = analyticsQueryResult map ((v,k) -> {
	environment: v.environment,
	apiIds: v.data.response[0]."api_id",
	clientIds: v.data.response[1]."client_id"
})

var prodApis=(apiManagerApis filter($.isProduction)).data
var prodApisAssets=prodApis.assets
var prodApiInstances=flatten(flatten(prodApisAssets).apis default [])

var sandboxApis=(apiManagerApis filter(not $.isProduction)).data
var sandboxApisAssets=sandboxApis.assets
var sandboxApiInstances=flatten(flatten(sandboxApisAssets).apis default [])
---
{
	businessGroup: vars.orgName,
	coreServicesMetrics: {
		users: {
			total: sizeOf(members.data),
			activeMembers: sizeOf(members.data  filter ($.enabled == true)),
			inactiveMembers: sizeOf(members.data  filter ($.enabled == false)),
			activeMembersLast60Days: sizeOf(members.data filter ($.lastLogin  >= (now() - |P60D|))),
			activeMembersLast30Days: sizeOf(members.data filter ($.lastLogin  >= (now() - |P30D|)))
		},
		environments: {
			total:  sizeOf(environments),
			production: sizeOf(environments  filter ($.isProduction)),
			sandbox: sizeOf(environments  filter (not $.isProduction)),
		}
	},
	designCenterMetrics: {
		total: sizeOf(designCenterProjects),
		apiSpecs: sizeOf(designCenterProjects filter($."type" == "raml")),
		fragments: sizeOf(designCenterProjects filter($."type" == "raml-fragment")),
		flowDesignerApps: "NA"
	},
	exchangeMetrics: {
		total: sizeOf(exchangeAssets) + sizeOf(exchangeAssets filter($."type" == "rest-api")),
		apiSpecs: sizeOf(exchangeAssets filter($."type" == "rest-api")),
		connectors: sizeOf(exchangeAssets filter($."type" == "rest-api")),
		fragments: sizeOf(exchangeAssets filter($."type" == "raml-fragment")),
		proxies: sizeOf(exchangeAssets filter($."type" == "http-api")),
		extensions: sizeOf(exchangeAssets filter($."type" == "extension")),
		custom: sizeOf(exchangeAssets filter($."type" == "custom"))	,
		overallSatisfaction: "NA"			
	},
	apiManagerMetrics: {
		clients: sizeOf(apiClients),
		apis: {
			production: {
				total: sum(prodApis.total),
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
				policiesUsed: ["NA"],
				policiesUsedTotal: "NA",
				transactions: "NA" //last x days on the period collected
			
			},
			sandbox: {
				total: sum(sandboxApis.total),
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
				policiesUsed: ["NA"],
				policiesUsedTotal: "NA",
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
					vcoresTotal: "NA",
					vcoresAvailable: "NA",
					vcoresUsed: 
						sum (cloudHubApps map (
							if(sizeOf($.data) > 0 and $.environment == "Production") (sum($.data map 
								($."workers"."type"."weight" * $."workers"."amount")
							)) else 0
					)),
					applicationsTotal: "NA",
					applicationsStarted: "NA",
					applicationsStopped: "NA",
					runtimesUsed: ["NA"],
					runtimesUsedTotal: "NA"
				},
				sandbox:{
					vcoresTotal: "NA",
					vcoresAvailable: "NA",
					vcoresUsed: sum (cloudHubApps map (
							if(sizeOf($.data) > 0 and $.environment != "Production") (sum($.data map 
								($."workers"."type"."weight" * $."workers"."amount")
							)) else 0
					)),
					applicationsTotal: "NA",
					applicationsStarted: "NA",
					applicationsStopped: "NA",
					runtimesUsed: ["NA"],
					runtimesUsedTotal: "NA"
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
				applicationsTotal: "NA",
				applicationsStarted: "NA",
				applicationsStopped: "NA",
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
				applicationsTotal: "NA",
				applicationsStarted: "NA",
				applicationsStopped: "NA",
				runtimesUsed: ["NA"],
				runtimesUsedTotal: "NA"
			}
		},
		hybrid: {
			production: {
				servers: "NA",
				clusters: "NA",
				serverGroups: "NA",
				applicationsTotal: "NA",
				applicationsStarted: "NA",
				applicationsStopped: "NA",
				runtimesUsed: ["NA"],
				runtimesUsedTotal: "NA"
			},
			sandbox:{
				servers: "NA",
				clusters: "NA",
				serverGroups: "NA",
				applicationsTotal: "NA",
				applicationsStarted: "NA",
				applicationsStopped: "NA",
				runtimesUsed: ["NA"],
				runtimesUsedTotal: "NA"
			}
		}
		
	}	
}
