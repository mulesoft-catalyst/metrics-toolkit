%dw 2.0
output application/json
import countBy from dw::core::Arrays
var environments = vars.environments
var entitlements = vars.entitlements
var errors = vars.errors

var cloudHubApps = if (payload[0].payload != null) payload[0].payload.payload else null
var exchangeAssets = payload[1].payload default []
var apiManagerApis = if (payload[2].payload != null) payload[2].payload[0].payload.payload else null
var apiClients = if (payload[2].payload != null) payload[2].payload[1].payload.applications else null
var apiAutomatedPolicies = if (payload[2].payload != null) payload[2].payload[2].payload.payload else null
var members = if (payload[3].payload != null) payload[3].payload[0].payload else null
var usage = if (payload[3].payload != null) payload[3].payload[1].payload else null
var designCenterProjects = payload[4].payload default []
var armApps = if (payload[5].payload != null) payload[5].payload[0].payload.payload else null
var armServers = if (payload[5].payload != null) payload[5].payload[1].payload.payload else null
var armClusters = if (payload[5].payload != null) payload[5].payload[2].payload.payload else null
var armServerGroups = if (payload[5].payload != null) payload[5].payload[3].payload.payload else null
var rtf = payload[6].payload default []
var analyticsQueryResult = if (payload[7].payload != null) payload[7].payload.payload else null
var mq = if (payload[8].payload != null) payload[8].payload.payload else null
var osv2 = if (payload[9].payload != null) payload[9].payload.payload else null

var RTF_TARGET_TYPE = 'MC'
var RTF_MI = "Mi"
var RTF_M = "m"
var RTF_WORKER = "worker"
var RTF_CONTROLLER = "controller"
var HYBRID_TARGET_TYPE = 'RR'
var APP_STATUS_RUNNING = "RUNNING"
var APP_STATUS_STARTED = "STARTED"

var ENV_TYPE_PROD = "Production"
var ENV_TYPE_SANDBOX = "Sandbox"

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

var groupedArrayByEnvironment = (arr) ->  ( (arr groupBy ($.environment)) mapObject { ($$): $.data } )

var securePolicies= p('api.securityPolicies')splitBy  (',')
//["client-id-enforcement","ip-allowlist","oauth","jwt-validation","authentication", "openidconnect-access-token-enforcement","external-oauth2-access-token-enforcement"]

var notGeneratedAssets = if (exchangeAssets is Array) (exchangeAssets filter($."isGenerated" == false)) else []
var ratedAssets = notGeneratedAssets filter ($."numberOfRates" > 0)
var assetsByType = (assetType) -> notGeneratedAssets filter($."type" == assetType)
var countAssetType = (assetType) -> sizeOf(assetsByType(assetType))

var assetHasDependency = (parentAsset, childAsset) -> (
    sizeOf(
        (parentAsset.dependencies filter ((dependency) ->
            dependency.groupId == childAsset.groupId
            and dependency.assetId == childAsset.assetId
        )) default []
    ) > 0
)

var assetReuseArray = (parentAssets, childAssets) -> (
    childAssets map (childAsset) -> (
        sizeOf(
            (parentAssets filter (assetHasDependency($,childAsset)))
            default []
        )
    )
)

var avgSafe = (array) -> if(sizeOf(array default []) > 0) avg(array) else 0

var assetReuseAvg = (parentAssetType, childAssetType) -> avgSafe(assetReuseArray(assetsByType(parentAssetType), assetsByType(childAssetType)))

var apiManagerImportsbyApiSpec = (apiSpecAsset, inProduction) -> sizeOf(
    (do {
        var apiManagerAssets = (apiManagerApis filter ($.isProduction == inProduction)).data.assets
        ---
        if (apiManagerAssets != null)
            flatten(
                apiManagerAssets
            ) filter ($.groupId == apiSpecAsset.groupId and $.assetId == apiSpecAsset.assetId)
        else []
    }) default []
)

var apiManagerImports = (inProduction) -> (
    assetsByType("rest-api") map ((asset) -> 
        apiManagerImportsbyApiSpec(asset,inProduction)
    )
)

var apiPoliciesApplied = (inProduction) -> do {
    flatten(apiManagerApis filter ($.isProduction == inProduction) map (environment) -> (
        flatten(environment.details map ((apiDetail) ->
            apiDetail.policies
        ))
    ))
}

var policiesAppliedByPolicy = (inProduction) -> (
    assetsByType("policy") map ((policy) ->
        sizeOf(
            apiPoliciesApplied(inProduction) filter (
                $.template.groupId == policy.groupId
                and $.template.assetId == policy.assetId
            )
            default []
        )
    )
)

var usableSandboxVcores = entitlements.vCoresSandbox.assigned - entitlements.vCoresSandbox.reassigned
var usableProdVcores = entitlements.vCoresProduction.assigned - entitlements.vCoresProduction.reassigned													
---
{
	date: vars.date,
	businessGroup: vars.orgName,
	businessGroupId: vars.orgId,
	coreServicesMetrics: {
		users: {
			total: sizeOf(members.data default []),
			activeMembers: sizeOf(members.data  filter ($.enabled == true) default []),
			inactiveMembers: sizeOf(members.data  filter ($.enabled == false) default []),
			activeMembersLast60Days: sizeOf(members.data filter (($.lastLogin default |2000-01-01T00:00:00.000Z|)  >= (now() - |P60D|)) default []),  // defaulting to |2000-01-01T00:00:00.000Z| for null cases
			activeMembersLast30Days: sizeOf(members.data filter (($.lastLogin default |2000-01-01T00:00:00.000Z|)  >= (now() - |P30D|)) default [])  // defaulting to |2000-01-01T00:00:00.000Z| for null cases
		},
		environments: {
			total:  sizeOf(environments default []),
			production: sizeOf(environments  filter ($.isProduction) default []),
			sandbox: sizeOf(environments  filter (not $.isProduction) default []),
		}
	},
	designCenterMetrics: {
		total: if (designCenterProjects is Array) (sizeOf(designCenterProjects default [])) else (0),
		apiSpecs: if (designCenterProjects is Array)  (sizeOf(designCenterProjects filter($."type" == "raml") default [])) else (0),
		fragments: if (designCenterProjects is Array) (sizeOf(designCenterProjects filter($."type" == "raml-fragment") default [])) else (0),
		flowDesignerApps: if  (designCenterProjects is Array) (sizeOf(designCenterProjects filter($."type" == "Mule_Application") default [])) else (0)
	},
	exchangeMetrics: {
            total: sizeOf(notGeneratedAssets),
		    apiSpecs: countAssetType("rest-api"),
            fragments: countAssetType("raml-fragment"),
            proxies: countAssetType("http-api"),
            soapApis: countAssetType("soap-api"),
            policies: countAssetType("policy"),
            //connectors -> was removed and replaced by mule3Connectors
            // Mule 3 DevKit components are connectors
		    mule3Connectors: countAssetType("connector"),
            // Mule 4 XML and Java SDK components are extensions
            extensions: countAssetType("extension"),
            applications: countAssetType("app"),
		    custom: countAssetType("custom"),
		    overallSatisfaction: if (sizeOf(ratedAssets) > 0) ((ratedAssets.rating reduce ($ + $$) default 0) / sizeOf(ratedAssets)) else 0,
        reuse: {
            // Avg of times a Fragment is imported by an API Spec
            fragments: assetReuseAvg("rest-api","raml-fragment"),
            // Avg of times an API Spec is implemented by an Application
            // Only valid for Applications uploaded to Exchange with RAML as a dependency
            implementedApis: assetReuseAvg("app","rest-api"),
            // Avg of times an API Spec is managed from API Manager (Sandbox environments)
            managedSboxApis: avgSafe(apiManagerImports(false)),
            // Avg of times an API Spec is managed from API Manager (Production environments)
            managedProdApis: avgSafe(apiManagerImports(true)),
            // Avg of times a Extension is imported by an Application
            // Only valid for Applications uploaded to Exchange with RAML as a dependency
            extensions: assetReuseAvg("app","extension"),
            // Avg of times a Custom Policy is applied on API Manager (Sandbox environments)
            appliedPoliciesSbox: avgSafe(policiesAppliedByPolicy(false)),
            // Avg of times a Custom Policy is applied on API Manager (Production environments)
            appliedPoliciesProd: avgSafe(policiesAppliedByPolicy(true))
        }
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
				apisWithSecurity: (flatten(getProdDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) countBy(($ contains(true))),
				apisWithoutSecurity: sizeOf(flatten(getProdDetails(apiManagerApis) default [])) -( (flatten(getProdDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) countBy(($ contains(true)))),
				apisWithContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(prodApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(prodApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(prodApiInstances.activeContractsCount filter ($ > 0) default []),
				contracts: sum(prodApiInstances.activeContractsCount default []),
				policiesUsed: flatten(flatten(getProdDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default [],
				policiesUsedTotal: sizeOf(flatten(flatten(getProdDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default []),
				automatedPoliciesUsed: flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getProdData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				transactions: sum(flatten(flatten(getProdData(analyticsQueryResult).response default [])."api_id" default [])..count default []), //last x days on the period collected
				details: apiManagerApis filter ($.isProduction) map ((item, index) -> {
					environmentName: item.environment,
					environmentType: ENV_TYPE_PROD,
					total: item.data.total,
					active: if (not isEmpty(flatten(flatten(item.data.assets).apis default []).lastActiveDate)) sizeOf(flatten(flatten(item.data.assets).apis default []).lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
					inactive: if (not isEmpty(flatten(flatten(item.data.assets).apis default []).lastActiveDate)) sizeOf(flatten(flatten(item.data.assets).apis default []).lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
					apiInstances: sum(flatten(item.data.assets).totalApis default []), 
					apiVersions: sizeOf(flatten(flatten(item.data.assets).apis default []).productVersion distinctBy $ default []),
					apisWithPolicies: sizeOf(flatten(item.details default []) [?(sizeOf($.policies default []) > 0)] default []),
					apisWithoutPolicies: sizeOf(flatten(item.details default []) [?(sizeOf($.policies default []) == 0)] default []),
					apisWithSecurity: sizeOf((flatten((flatten(item.details) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []),
					apisWithoutSecurity: sizeOf(flatten(item.details default [])) - sizeOf((flatten((flatten(item.details) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []), 
					apisWithContracts: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 0) default []),
					apisWithoutContracts: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ == 0) default []),
					apisWithMoreThanOneConsumer: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 1) default []),
					apisWithOneOrMoreConsumers: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 0) default []),
					contracts: sum(flatten(flatten(item.data.assets).apis default []).activeContractsCount default []),				
					policiesUsed: flatten(flatten(item.details default []).policies default []).template.assetId  distinctBy $ default [],
					policiesUsedTotal: sizeOf(flatten(flatten(item.details default []).policies default []).template.assetId  distinctBy $ default []),
					automatedPoliciesUsed: flatten(groupedArrayByEnvironment(apiAutomatedPolicies default [])[item.environment].automatedPolicies default []).assetId distinctBy ($) default [],
					automatedPoliciesUsedTotal: sizeOf(flatten(groupedArrayByEnvironment(apiAutomatedPolicies default [])[item.environment].automatedPolicies default []).assetId distinctBy ($) default []),
					transactions: sum(flatten(flatten(groupedArrayByEnvironment(analyticsQueryResult)[item.environment].response default [])."api_id" default [])..count default []), //last x days on the period collected
				}) default []
			},
			sandbox: {
				total: sum(sandboxApis.total default []),
				active: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
				inactive: if (not isEmpty(sandboxApiInstances.lastActiveDate)) sizeOf(sandboxApiInstances.lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
				apiInstances: sum(flatten(sandboxApis.assets).totalApis default []), 
				apiVersions: sizeOf(sandboxApiInstances.productVersion distinctBy $ default []),
				apisWithPolicies: sizeOf(flatten(getSandboxDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) > 0)] default []),
				apisWithoutPolicies: sizeOf(flatten(getSandboxDetails(apiManagerApis) default []) [?(sizeOf($.policies default []) == 0)] default []),
				apisWithSecurity: (flatten(getSandboxDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) countBy(($ contains(true))),
				apisWithoutSecurity: sizeOf(flatten(getSandboxDetails(apiManagerApis) default [])) -((flatten(getSandboxDetails(apiManagerApis)) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) countBy(($ contains(true)))),
				apisWithContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				apisWithoutContracts: sizeOf(sandboxApiInstances.activeContractsCount filter ($ == 0) default []),
				apisWithMoreThanOneConsumer: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 1) default []),
				apisWithOneOrMoreConsumers: sizeOf(sandboxApiInstances.activeContractsCount filter ($ > 0) default []),
				contracts: sum(sandboxApiInstances.activeContractsCount default []),				
				policiesUsed: flatten(flatten(getSandboxDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default [],
				policiesUsedTotal: sizeOf(flatten(flatten(getSandboxDetails(apiManagerApis) default []).policies default []).template.assetId  distinctBy $ default []),
				automatedPoliciesUsed: flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default [],
				automatedPoliciesUsedTotal: sizeOf(flatten(getSandboxData(apiAutomatedPolicies default []).automatedPolicies default []).assetId distinctBy ($) default []),
				transactions: sum(flatten(flatten(getSandboxData(analyticsQueryResult).response default [])."api_id" default [])..count default []), //last x days on the period collected
				details: apiManagerApis filter (not $.isProduction) map ((item, index) -> {
					environmentName: item.environment,
					environmentType: ENV_TYPE_SANDBOX,
					total: item.data.total,
					active: if (not isEmpty(flatten(flatten(item.data.assets).apis default []).lastActiveDate)) sizeOf(flatten(flatten(item.data.assets).apis default []).lastActiveDate filter ($!=null and ($ >= now() -|P1D|)) default []) else 0,
					inactive: if (not isEmpty(flatten(flatten(item.data.assets).apis default []).lastActiveDate)) sizeOf(flatten(flatten(item.data.assets).apis default []).lastActiveDate filter ($==null or ($ < now() -|P1D|)) default []) else 0,
					apiInstances: sum(flatten(item.data.assets).totalApis default []), 
					apiVersions: sizeOf(flatten(flatten(item.data.assets).apis default []).productVersion distinctBy $ default []),
					apisWithPolicies: sizeOf(flatten(item.details default []) [?(sizeOf($.policies default []) > 0)] default []),
					apisWithoutPolicies: sizeOf(flatten(item.details default []) [?(sizeOf($.policies default []) == 0)] default []),
					apisWithSecurity: sizeOf((flatten((flatten(item.details) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []),
					apisWithoutSecurity: sizeOf(flatten(item.details default [])) - sizeOf((flatten((flatten(item.details) default [] map ((v,k) -> if(sizeOf(v.policies default []) > 0) (v.policies map ((v2,k2) -> v2.template.assetId  )) else ["NA"] ) default []) map ((v,k) -> (v map (securePolicies contains $))) map ($[?($==true)])))[?($ == true)] default []), 
					apisWithContracts: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 0) default []),
					apisWithoutContracts: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ == 0) default []),
					apisWithMoreThanOneConsumer: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 1) default []),
					apisWithOneOrMoreConsumers: sizeOf(flatten(flatten(item.data.assets).apis default []).activeContractsCount filter ($ > 0) default []),
					contracts: sum(flatten(flatten(item.data.assets).apis default []).activeContractsCount default []),				
					policiesUsed: flatten(flatten(item.details default []).policies default []).template.assetId  distinctBy $ default [],
					policiesUsedTotal: sizeOf(flatten(flatten(item.details default []).policies default []).template.assetId  distinctBy $ default []),
					automatedPoliciesUsed: flatten(groupedArrayByEnvironment(apiAutomatedPolicies default [])[item.environment].automatedPolicies default []).assetId distinctBy ($) default [],
					automatedPoliciesUsedTotal: sizeOf(flatten(groupedArrayByEnvironment(apiAutomatedPolicies default [])[item.environment].automatedPolicies default []).assetId distinctBy ($) default []),
					transactions: sum(flatten(flatten(groupedArrayByEnvironment(analyticsQueryResult)[item.environment].response default [])."api_id" default [])..count default []), //last x days on the period collected
				}) default []	
			}
		}	
	},
	runtimeManagerMetrics: {
		cloudhub: {
			networking: {
				vpcsTotal: entitlements.vpcs.assigned,
				vpcsAvailable: (entitlements.vpcs.assigned default 0) - (usage.vpcsConsumed default 0),
				vpcsUsed: usage.vpcsConsumed,
				vpnsTotal: entitlements.vpns.assigned,
				vpnsAvailable: (entitlements.vpns.assigned default 0) - (usage.vpnsConsumed default 0),
				vpnsUsed: usage.vpnsConsumed,
				dlbsTotal: entitlements.loadBalancer.assigned,
				dlbsAvailable: (entitlements.loadBalancer.assigned default 0) - (usage.loadBalancersConsumed default 0),
				dlbsUsed: usage.loadBalancersConsumed,
				staticIPsTotal: entitlements.staticIps.assigned,
				staticIPsAvailable: (entitlements.staticIps.assigned default 0) - (usage.staticIpsConsumed default 0),
				staticIPsUsed: usage.staticIpsConsumed
			},
			
			applications:{
				production: {
					vcoresTotal: usableProdVcores,
					vcoresAvailable: usableProdVcores - sum((flatten(getProdData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum((flatten(getProdData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten(getProdData(cloudHubApps) default []) default []),
					applicationsStarted: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default []),
					applicationsStopped: sizeOf(flatten(getProdData(cloudHubApps) default []) filter ($.status != APP_STATUS_STARTED) default []),
					runtimesUsed: flatten(getProdData(cloudHubApps) default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten(getProdData(cloudHubApps) default []).muleVersion.version distinctBy ($) default []),
					details: cloudHubApps filter ($.isProduction) map ((item, index) -> {
						environmentName: item.environment,
						environmentType: ENV_TYPE_PROD,
						vcoresUsed: sum((flatten(item.data default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
						applicationsTotal: sizeOf(flatten(item.data default []) default []),
						applicationsStarted: sizeOf(flatten(item.data default []) filter ($.status == APP_STATUS_STARTED) default []),
						applicationsStopped: sizeOf(flatten(item.data default []) filter ($.status != APP_STATUS_STARTED) default []),
						runtimesUsed: flatten(item.data default []).muleVersion.version distinctBy ($) default[],
						runtimesUsedTotal: sizeOf(flatten(item.data default []).muleVersion.version distinctBy ($) default [])	
						
					}) default []
				},
				sandbox:{
					vcoresTotal: usableSandboxVcores,
					vcoresAvailable: usableSandboxVcores - sum((flatten(getSandboxData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
					vcoresUsed: sum((flatten(getSandboxData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
					applicationsTotal: sizeOf(flatten(getSandboxData(cloudHubApps) default []) default []),
					applicationsStarted: sizeOf(flatten(getSandboxData(cloudHubApps) default []) filter ($.status == APP_STATUS_STARTED) default []),
					applicationsStopped: sizeOf(flatten(getSandboxData(cloudHubApps) default []) filter ($.status != APP_STATUS_STARTED) default []),
					runtimesUsed: flatten(getSandboxData(cloudHubApps) default []).muleVersion.version distinctBy ($) default[],
					runtimesUsedTotal: sizeOf(flatten(getSandboxData(cloudHubApps) default []).muleVersion.version distinctBy ($) default []),
					details: cloudHubApps filter (not $.isProduction) map ((item, index) -> {
						environmentName: item.environment,
						environmentType: ENV_TYPE_SANDBOX,
						vcoresUsed: sum((flatten(item.data default []) filter ($.status == APP_STATUS_STARTED) default [] ) map ($.workers."type".weight * $.workers.amount)),
						applicationsTotal: sizeOf(flatten(item.data default []) default []),
						applicationsStarted: sizeOf(flatten(item.data default []) filter ($.status == APP_STATUS_STARTED) default []),
						applicationsStopped: sizeOf(flatten(item.data default []) filter ($.status != APP_STATUS_STARTED) default []),
						runtimesUsed: flatten(item.data default []).muleVersion.version distinctBy ($) default[],
						runtimesUsedTotal: sizeOf(flatten(item.data default []).muleVersion.version distinctBy ($) default [])	
						
					}) default []
				}
			}
		},
		rtf: {
			capacity: {
				fabrics: sizeOf(rtf),
    				workers: sizeOf((flatten(rtf.nodes) filter($.role == RTF_WORKER) default []) default []),
    				controllers: sizeOf((flatten(rtf.nodes) filter($.role == RTF_CONTROLLER) default []) default []),
    				coresTotal: sum((flatten(rtf.nodes) filter($.role == RTF_WORKER) default []).capacity.cpuMillis default [])/1000,
   				    memoryTotal: sum((flatten(rtf.nodes) filter($.role == RTF_WORKER) default []).capacity.memoryMi default [])/1000,
    				coresPerFabric: if (sizeOf(rtf) > 0) (sum((flatten(rtf.nodes) filter($.role == RTF_WORKER) default []).capacity.cpuMillis default [])/(sizeOf(rtf) * 1000)) else 0,
    				memoryPerFabric: if (sizeOf(rtf) > 0) (sum((flatten(rtf.nodes) filter($.role == RTF_WORKER) default []).capacity.memoryMi default [])/(sizeOf(rtf) * 1000)) else 0
			},
			applications: {
				production: {
					//coresAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					coresReserved: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000)  + 
    					(sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					coresReservedA: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					coresReservedB: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					//memoryAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					memoryReserved: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000) + 
        				(sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
    				memoryReservedA: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
    				memoryReservedB: (sum(((flatten(getProdDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
					applicationsTotal: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default []),
					applicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status == APP_STATUS_RUNNING) default []),
					applicationsStopped: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status != APP_STATUS_RUNNING) default []),
					runtimesUsed: flatten(getProdDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
					runtimesUsedTotal: sizeOf(flatten(getProdDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default []),			
					details: armApps filter ($.isProduction) map ((item, index) -> {
						environmentName: item.environment,
						environmentType: ENV_TYPE_PROD,
						coresReserved: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000)  + 
	    					(sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
						coresReservedA: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
						coresReservedB: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),			
						memoryReserved: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000) + 
	        				(sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    				memoryReservedA: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    				memoryReservedB: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    					
						applicationsTotal: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default []),
						applicationsStarted: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status == APP_STATUS_RUNNING) default []),
						applicationsStopped: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status != APP_STATUS_RUNNING) default []),
						runtimesUsed: flatten(item.details default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
						runtimesUsedTotal: sizeOf(flatten(item.details default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [])
					}) default []
				},
				sandbox:{
					//coresAvailable: "NA", //cores // Not able to calculate because a fabric can be associated with multiple environments of any type
					coresReserved: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000)  + 
    					(sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					coresReservedA: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					coresReservedB: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
					//memoryAvailable: "NA", //Gigs // Not able to calculate because a fabric can be associated with multiple environments of any type
					
					memoryReserved: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000) + 
        				(sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
    				memoryReservedA: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
    				memoryReservedB: (sum(((flatten(getSandboxDetails(armApps) default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
    					
					applicationsTotal: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default []),
					applicationsStarted: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status == APP_STATUS_RUNNING) default []),
					applicationsStopped: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status != APP_STATUS_RUNNING) default []),
					runtimesUsed: flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
					runtimesUsedTotal: sizeOf(flatten(getSandboxDetails(armApps) default []).target.deploymentSettings.runtimeVersion distinctBy ($) default []),
					details: armApps filter (not $.isProduction) map ((item, index) -> {
						environmentName: item.environment,
						environmentType: ENV_TYPE_SANDBOX,
						coresReserved: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000)  + 
	    					(sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
						coresReservedA: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.cpu.reserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),
						coresReservedB: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	        				(($.target.deploymentSettings.cpuReserved) replace RTF_M with "") as Number * ($.target.replicas as Number)) default [])/1000),			
						memoryReserved: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000) + 
	        				(sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    				memoryReservedA: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources != null))) map (
	        				(($.target.deploymentSettings.resources.memory.reserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    				memoryReservedB: (sum(((flatten(item.details default []) filter($.target.provider == RTF_TARGET_TYPE and $.application.status == APP_STATUS_RUNNING and $.target.deploymentSettings.resources == null))) map (
	       					 (($.target.deploymentSettings.memoryReserved) replace RTF_MI with "") as Number * ($.target.replicas as Number)) default [])/1000),
	    					
						applicationsTotal: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default []),
						applicationsStarted: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status == APP_STATUS_RUNNING) default []),
						applicationsStopped: sizeOf(flatten(item.data.items default []) filter($.target.provider == RTF_TARGET_TYPE) default [] filter ($.application.status != APP_STATUS_RUNNING) default []),
						runtimesUsed: flatten(item.details default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [],
						runtimesUsedTotal: sizeOf(flatten(item.details default []).target.deploymentSettings.runtimeVersion distinctBy ($) default [])
					}) default []
				}
			}
		},
		hybrid: {
			production: {
				servers: sizeOf(flatten(getProdData(armServers).data default []) default []),
				clusters: sizeOf(flatten(getProdData(armClusters).data default []) default []),
				serverGroups: sizeOf(flatten(getProdData(armServerGroups).data default []) default []),
				applicationsTotal: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default []),
				applicationsStarted: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status == APP_STATUS_STARTED) default []),
				applicationsStopped: sizeOf(flatten(getProdData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status != APP_STATUS_STARTED) default []),
				runtimesUsed: flatten(getProdData(armServers).data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten(getProdData(armServers).data default []).muleVersion distinctBy $ default []),
				details: armApps filter ($.isProduction) map ((item, index) -> {
					environmentName: item.environment,
					environmentType: ENV_TYPE_PROD,
					servers: sizeOf(flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []) default []),
					clusters: sizeOf(flatten(groupedArrayByEnvironment(armClusters)[item.environment].data default []) default []),
					serverGroups: sizeOf(flatten(groupedArrayByEnvironment(armServerGroups)[item.environment].data default []) default []),
					applicationsTotal: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default []),
					applicationsStarted: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status == APP_STATUS_STARTED) default []),
					applicationsStopped: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status != APP_STATUS_STARTED) default []),
					runtimesUsed: flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []).muleVersion distinctBy $ default [],
					runtimesUsedTotal: sizeOf(flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []).muleVersion distinctBy $ default []),
				}) default []
			},
			sandbox:{
				servers: sizeOf(flatten(getSandboxData(armServers).data default []) default []),
				clusters: sizeOf(flatten(getSandboxData(armClusters).data default []) default []),
				serverGroups: sizeOf(flatten(getSandboxData(armServerGroups).data default []) default []),
				applicationsTotal: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default []),
				applicationsStarted: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status == APP_STATUS_STARTED) default []),
				applicationsStopped: sizeOf(flatten(getSandboxData(armApps).items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status != APP_STATUS_STARTED) default []),
				runtimesUsed: flatten(getSandboxData(armServers).data default []).muleVersion distinctBy $ default [],
				runtimesUsedTotal: sizeOf(flatten(getSandboxData(armServers).data default []).muleVersion distinctBy $ default []),
				details: armApps filter (not $.isProduction) map ((item, index) -> {
					environmentName: item.environment,
					environmentType: ENV_TYPE_SANDBOX,
					servers: sizeOf(flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []) default []),
					clusters: sizeOf(flatten(groupedArrayByEnvironment(armClusters)[item.environment].data default []) default []),
					serverGroups: sizeOf(flatten(groupedArrayByEnvironment(armServerGroups)[item.environment].data default []) default []),
					applicationsTotal: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default []),
					applicationsStarted: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status == APP_STATUS_STARTED) default []),
					applicationsStopped: sizeOf(flatten(item.data.items default []) filter($.target.provider == HYBRID_TARGET_TYPE) default [] filter ($.status != APP_STATUS_STARTED) default []),
					runtimesUsed: flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []).muleVersion distinctBy $ default [],
					runtimesUsedTotal: sizeOf(flatten(groupedArrayByEnvironment(armServers)[item.environment].data default []).muleVersion distinctBy $ default []),
				}) default []
			}
		}
	},
	mqMetrics: {
		stats: {
			summary: {
				production:{
					queues: {
						commonQueues: sum(flatten(getProdData(mq)).queues.commonQueues default [0]),
						fifoQueues: sum(flatten(getProdData(mq)).queues.fifoQueues default [0]),
						messagesInFlight: sum(flatten(getProdData(mq)).queues.messagesInFlight default [0]),
						messagesSent: sum(flatten(getProdData(mq)).queues.messagesSent default [0]),
						messagesReceived: sum(flatten(getProdData(mq)).queues.messagesReceived default [0]),
						messagesAck: sum(flatten(getProdData(mq)).queues.messagesAck default [0]),
						details: mq filter ($.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_PROD,
							commonQueues: sum(flatten(item.data).queues.commonQueues default [0]),
							fifoQueues: sum(flatten(item.data).queues.fifoQueues default [0]),
							messagesInFlight: sum(flatten(item.data).queues.messagesInFlight default [0]),
							messagesSent: sum(flatten(item.data).queues.messagesSent default [0]),
							messagesReceived: sum(flatten(item.data).queues.messagesReceived default [0]),
							messagesAck: sum(flatten(item.data).queues.messagesAck default [0]),
						}) default []
					},
					exchanges: {
						exchangeQueues: sum(flatten(getProdData(mq)).exchanges.exchangeQueues default [0]),
						messagesPublished: sum(flatten(getProdData(mq)).exchanges.messagesPublished default [0]),
						messagesDelivered: sum(flatten(getProdData(mq)).exchanges.messagesDelivered default [0]),
						details: mq filter ($.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_PROD,
							exchangeQueues: sum(flatten(item.data).exchanges.exchangeQueues default [0]),
							messagesPublished: sum(flatten(item.data).exchanges.messagesPublished default [0]),
							messagesDelivered: sum(flatten(item.data).exchanges.messagesDelivered default [0]),
						}) default []
					}
				}, 
				sandbox: {
					queues: {
						commonQueues: sum(flatten(getSandboxData(mq)).queues.commonQueues default [0]),
						fifoQueues: sum(flatten(getSandboxData(mq)).queues.fifoQueues default [0]),
						messagesInFlight: sum(flatten(getSandboxData(mq)).queues.messagesInFlight default [0]),
						messagesSent: sum(flatten(getSandboxData(mq)).queues.messagesSent default [0]),
						messagesReceived: sum(flatten(getSandboxData(mq)).queues.messagesReceived default [0]),
						messagesAck: sum(flatten(getSandboxData(mq)).queues.messagesAck default [0]),
						details: mq filter (not $.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_SANDBOX,
							commonQueues: sum(flatten(item.data).queues.commonQueues default [0]),
							fifoQueues: sum(flatten(item.data).queues.fifoQueues default [0]),
							messagesInFlight: sum(flatten(item.data).queues.messagesInFlight default [0]),
							messagesSent: sum(flatten(item.data).queues.messagesSent default [0]),
							messagesReceived: sum(flatten(item.data).queues.messagesReceived default [0]),
							messagesAck: sum(flatten(item.data).queues.messagesAck default [0]),
						}) default []
					},
					exchanges: {
						exchangeQueues: sum(flatten(getSandboxData(mq)).exchanges.exchangeQueues default [0]),
						messagesPublished: sum(flatten(getSandboxData(mq)).exchanges.messagesPublished default [0]),
						messagesDelivered: sum(flatten(getSandboxData(mq)).exchanges.messagesDelivered default [0]),
						details: mq filter (not $.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_SANDBOX,
							exchangeQueues: sum(flatten(item.data).exchanges.exchangeQueues default [0]),
							messagesPublished: sum(flatten(item.data).exchanges.messagesPublished default [0]),
							messagesDelivered: sum(flatten(item.data).exchanges.messagesDelivered default [0]),
						}) default []
					}
				}
			},
			byRegion: {
				production: (getProdData(mq)[0] default []),
				sandbox: (getSandboxData(mq)[0] default [])
			}
			
		},
	},
	osV2Metrics: {
		stats: {
			production: { 
				requestCount: sum(flatten(getProdData(osv2)).objectStoreRequestCount default [0]),
				details: osv2 filter ($.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_PROD,
							requestCount: sum(flatten(item.data).objectStoreRequestCount default [0])
						}) default []
			}, 
			sandbox: { 
				requestCount: sum(flatten(getSandboxData(osv2)).objectStoreRequestCount default [0]),
				details: osv2 filter (not $.isProduction) map ((item, index) -> {
							environmentName: item.environment,
							environmentType: ENV_TYPE_SANDBOX,
							requestCount: sum(flatten(item.data).objectStoreRequestCount default [0])
						}) default []
			}
		}
	},
	errors: errors	
}
