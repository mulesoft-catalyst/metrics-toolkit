%dw 2.0
output application/json
var cloudHubApps = payload[0].payload.payload
var exchangeAssets = payload[1].payload
var apiManagerApis = payload[2].payload.payload
var members = payload[3].payload
var designCenterProjects = payload[4].payload
var analyticsQueryResult = payload[5].payload.payload

var analyticsEnrichedData = analyticsQueryResult map ((v,k) -> {
	environment: v.environment,
	apiIds: v.data.response[0]."api_id",
	clientIds: v.data.response[1]."client_id"
})
---
{
	coreservicesMetrics: {
		membersMetrics: sizeOf(members.data  filter ($.enabled == true)),
		environments: sizeOf(cloudHubApps.environment),
	},
	designCenterMetrics: {
		total: sizeOf(designCenterProjects),
		apiSpecs: sizeOf(designCenterProjects filter($."type" == "raml")),
		fragments: sizeOf(designCenterProjects filter($."type" == "raml-fragment")),
	},
	exchangeMetrics: {
		exchangeAssets: {
			total: sizeOf(exchangeAssets) + sizeOf(exchangeAssets filter($."type" == "rest-api")),
			apiSpecs: sizeOf(exchangeAssets filter($."type" == "rest-api")),
			connectors: sizeOf(exchangeAssets filter($."type" == "rest-api")),
			fragments: sizeOf(exchangeAssets filter($."type" == "raml-fragment")),
			proxies: sizeOf(exchangeAssets filter($."type" == "http-api")),
			extensions: sizeOf(exchangeAssets filter($."type" == "extension")),
			custom: sizeOf(exchangeAssets filter($."type" == "custom"))		
		}
	},
	apiManagerMetrics: {
		apiEnvironments: apiManagerApis map {
			environment: $.environment,
			apis: $.data.total
		},
		totals: {
			nonProdAPIs: sum((apiManagerApis filter($.environment != "Production")).data.total),
			prodAPIs: sum ((apiManagerApis filter($.environment == "Production")).data.total)
		}
	},
	cloudHubMetrics: {
		environmentsMetrics: cloudHubApps map {
			environment: $.environment,
			applications: sizeOf($.data),
			vCoresUsed: if(sizeOf($.data) > 0) (sum($.data map {
				size: $."workers"."type"."weight" * $."workers"."amount"
			}.size)) else 0
		},
		vCoreUsageTotalSandbox: sum (cloudHubApps map (
			if(sizeOf($.data) > 0 and $.environment != "Production") (sum($.data map 
				($."workers"."type"."weight" * $."workers"."amount")
			)) else 0
		)),
		vCoreUsageTotalProduction: sum (cloudHubApps map (
			if(sizeOf($.data) > 0 and $.environment == "Production") (sum($.data map 
				($."workers"."type"."weight" * $."workers"."amount")
			)) else 0
		)),
		applicationDetailsMetrics: cloudHubApps map {
			environment: $.environment,
			applications: $.data map {
				domain: $.domain,
				size: $."workers"."type"."weight" * $."workers"."amount",
				fileName: $.fileName
			}	
		}
	},
	analyticsMetrics: analyticsEnrichedData,
	apisRaw: apiManagerApis map {
		environment: $.environment,
		data: $.data.assets map {
			id: $.id,
			name:$.assetId
		}
	},
	apisMetrics: apiManagerApis map (api, index) -> {
		environment: api.environment,
		details: api.data.assets map (asset, index) -> {
			apiName: asset.assetId,
			count: ((analyticsEnrichedData filter ($.environment == api.environment))[0].data.response[0]."api_id")[asset.id]
		}
		//environment: $.environment,
		//apis: {
		//	name: $.data.assets filter ($.id == (analyticsEnrichedData filter($.environment == )))
		//	count: 
		//}
	}
}