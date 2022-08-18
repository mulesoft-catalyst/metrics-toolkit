%dw 2.0
var accessManagement = "Access Management"
var designCenter = "Design Center"
var exchange = "Exchange"
var apiManager = "API Manager"
var apiAnalytics = "API Analytics"
var runtimeManagerCH = "Runtime Manager - CloudHub"
var runtimeManagerHybrid = "Runtime Manager - ARM"
var runtimeManagerRTF = "Runtime Manager - RTF"
var mq= "Anypoint MQ"
var osv2Label = "ObjectStore V2"

var envSandbox = "Sandbox"
var envProduction = "Production"
var envNA = "NA"

//Populate common fields for each metric
fun commonFields(event) = {
    businessGroup: event.businessGroup default "NA", 
    date: event.date default "NA", 
    group: event.group default "NA", 
    environmentType: event.environmentType default "NA",
    environmentName: event.environmentName default "NA"
}

//Function to populate the API Manager metrics for each environment 
fun getEnvironmentApiMetrics(apiList, event) = 
    flatten(apiList map((api, apiIndex) -> [
        {
            name: "API Manager API Specs Managed Total", value: api.total,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Total", value: api.apiInstances,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Active Total", value: api.active,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Inactive Total", value: api.inactive,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Versions Total", value: api.apiVersions,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances With Policies Total", value: api.apisWithPolicies,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Without Policies Total", value: api.apisWithoutPolicies,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances With Security Policies Total", value: api.apisWithSecurity,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Without Security Policies Total", value: api.apisWithoutSecurity,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances With Contracts Total", value: api.apisWithContracts,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances Without Contracts Total", value: api.apisWithoutContracts,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances With More Than One Consumer Total", value: api.apisWithMoreThanOneConsumer,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Instances With One or More Consumers Total", value: api.apisWithOneOrMoreConsumers,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager API Contracts Total", value: api.contracts,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager Policies Used", value: api.policiesUsed joinBy " ",
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager Policies Used Total", value: api.policiesUsedTotal,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager Automated Policies Used", value: api.automatedPoliciesUsed joinBy " ",
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Manager Automated Policies Used Total", value: api.automatedPoliciesUsedTotal,
        }++ commonFields(event ++ api ++ {group: apiManager}),
        {
            name: "API Analytics Transactions Last 30 days Total", value: api.transactions,
        }++ commonFields(event ++ api ++ {group: apiAnalytics})
    ]))

//Function to populate the CH apps for each environment 
fun getChAppMetrics(appList, event) = 
    flatten(appList map((app, appIndex) -> [
        {
            name: "CloudHub vCores Used Total", value: app.vcoresUsed
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH}),
        {
            name: "CloudHub Applications Total", value: app.applicationsTotal
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH}),
        {
            name: "CloudHub Applications Started Total", value: app.applicationsStarted
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH}),
        {
            name: "CloudHub Applications Stopped Total", value: app.applicationsStopped
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH}),
        {
            name: "CloudHub Runtime Versions Used", value: app.runtimesUsed joinBy " "
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH}),
        {
            name: "CloudHub Runtime Versions Used Total", value: app.runtimesUsedTotal
        } ++ commonFields(event ++ app ++ {group: runtimeManagerCH})
    ]))
//Function to populate the RTF metrics for each environment     
fun getRtfEnvMetrics(rtf, event) = 
    flatten(rtf map ((env, index) -> [
        {
       name: "RTF Cores Used Total", value: env.coresUsed default 0
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Cores Reserved Total", value: env.coresReserved default 0
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Memory Used Total", value: env.memoryUsed default 0
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Applications Total", value: env.applicationsTotal
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Applications Started Total", value: env.applicationsStarted
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Applications Stopped Total", value: env.applicationsStopped
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Runtime Versions Used", value: env.runtimesUsed joinBy " "
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Runtime Versions Used Total", value: env.runtimesUsedTotal
        } ++ commonFields(event ++ env ++ {group: runtimeManagerRTF})
    ]))
//Function to populate the ARM metrics for each environment
fun getArmEnvMetrics(arm, event) = 
    flatten(arm map((env, index) -> [
        {
            name: "Standalone Mule Servers Total", value: env.servers
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Clusters Total", value: env.clusters
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Server Groups Total", value: env.serverGroups
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Applications Total", value: env.applicationsTotal
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Applications Started Total", value: env.applicationsStarted
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Applications Stopped Total", value: env.applicationsStopped
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Runtime Versions", value: env.runtimesUsed joinBy " "
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid}),
        {
            name: "Standalone Mule Runtime Versions Total", value: env.runtimesUsedTotal
        }++ commonFields(event ++ env ++ {group: runtimeManagerHybrid})
    ]))
//Function to populate the Anypoint MQ metrics for each environment
fun getAmqEnvMetrics(amq, event) = 
    flatten(
        amq.queues.details map((queues, index) -> [
        {   //Removing summary from metric names 
            name: "Anypoint MQ - Total Queues", value: queues.commonQueues
        }++ commonFields(event ++ queues ++ {group: mq}),
        {
            name: "Anypoint MQ - Total FIFO Queues", value: queues.fifoQueues,
        }++ commonFields(event ++ queues ++ {group: mq}),
        {
            name: "Anypoint MQ - Queues - Total Messages Sent", value: queues.messagesSent,
        }++ commonFields(event ++ queues ++ {group: mq}),
        {
            name: "Anypoint MQ - Queues - Total Messages Received", value: queues.messagesReceived,
        }++ commonFields(event ++ queues ++ {group: mq}),
        {
            name: "Anypoint MQ - Queues - Total Messages ACK", value: queues.messagesAck,
        }++ commonFields(event ++ queues ++ {group: mq}),
        {
            name: "Anypoint MQ - Queues - Total Messages In Flight", value: queues.messagesInFlight,
        }++ commonFields(event ++ queues ++ {group: mq}),
    ]))
    ++ flatten(amq.exchanges.details map((e, index) -> [
        {
            name: "Anypoint MQ - Total Exchanges", value: e.exchangeQueues
        }++ commonFields(event ++ e ++ {group: mq}),
        {
            name: "Anypoint MQ - Exchanges - Total Messages Published", value: e.messagesPublished,
        }++ commonFields(event ++ e ++ {group: mq}),
        {
            name: "Anypoint MQ - Exchanges - Total Messages Delivered", value: e.messagesDelivered,
        }++ commonFields(event ++ e ++ {group: mq})
    ]))
//Function to populate the Anypoint MQ metrics for each environment
fun getOsv2EnvMetrics(osv2, event) = 
    flatten(osv2 map((env, index) -> [
        {
            name: "OSv2 - Request count", value: env.requestCount
        } ++ commonFields(event ++ env ++ {group: osv2Label})
    ]))
    
---
flatten (payload map ((event, eventIndex) -> (
    [
    //Coreservices
    {name: "Users Total", value: event.coreServicesMetrics.users.total
    } ++ commonFields(event ++ {group: accessManagement}),
    {name: "Active Users", value: event.coreServicesMetrics.users.activeMembers
    } ++ commonFields(event ++ {group: accessManagement}),
    {name: "Inactive Users", value: event.coreServicesMetrics.users.inactiveMembers
    } ++ commonFields(event ++ {group: accessManagement}), 
    {name: "Active Users Last 60 days", value: event.coreServicesMetrics.users.activeMembersLast60Days
    } ++ commonFields(event ++ {group: accessManagement}),
    {name: "Active Users Last 30 days", value: event.coreServicesMetrics.users.activeMembersLast30Days
    } ++ commonFields(event ++ {group: accessManagement}), 
    {name: "Environments Total", value: event.coreServicesMetrics.environments.total
    } ++ commonFields(event ++ {group: accessManagement}), 
    {name: "Environments Production Total", value: event.coreServicesMetrics.environments.production
    } ++ commonFields(event ++ {group: accessManagement}), 
    {name: "Environments Sandbox Total", value: event.coreServicesMetrics.environments.sandbox
    } ++ commonFields(event ++ {group: accessManagement}),
    //Design Center 
    {name: "Design Center Assets Total", value: event.designCenterMetrics.total
    } ++ commonFields(event ++ {group: designCenter}), 
    {name: "Design Center API Specs Total", value: event.designCenterMetrics.apiSpecs
    } ++ commonFields(event ++ {group: designCenter}),  
    {name: "Design Center Fragments Total", value: event.designCenterMetrics.fragments
    } ++ commonFields(event ++ {group: designCenter}),  
    {name: "Design Center Flow Designer Apps Total", value: event.designCenterMetrics.flowDesignerApps
    } ++ commonFields(event ++ {group: designCenter}), 
    //Exchange
    {
       name: "Exchange Assets Total", value: event.exchangeMetrics.total
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange API Specs Total", value: event.exchangeMetrics.apiSpecs
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange Connectors Total", value: event.exchangeMetrics.mule3Connectors
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange Fragments Total", value: event.exchangeMetrics.fragments
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange HTTP Proxies Total", value: event.exchangeMetrics.proxies
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange Extensions Total", value: event.exchangeMetrics.extensions
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange Custom Assets Total", value: event.exchangeMetrics.custom
    } ++ commonFields(event ++ {group: exchange}),  
    {
       name: "Exchange Overall Satisfaction", value: event.exchangeMetrics.overallSatisfaction
    } ++ commonFields(event ++ {group: exchange}),     
    //Runtime Manager - CloudHub Networking
    {
       name: "CloudHub VPCs Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsTotal,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub VPCs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsAvailable,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub VPCs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsUsed,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub VPNs Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsTotal,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub VPNs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsAvailable,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub VPNs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsUsed,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub DLBs Total", value: event.runtimeManagerMetrics.cloudhub.networking.dlbsTotal,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub DLBs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.dlbsAvailable,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub DLBs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.dlbsUsed,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub Static IPs Total", value: event.runtimeManagerMetrics.cloudhub.networking.staticIPsTotal,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub Static IPs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.staticIPsAvailable,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
        {
        name: "CloudHub Static IPs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.staticIPsUsed,
    } ++ commonFields(event ++ {group: runtimeManagerCH}),     
    //API Manager - Client Apps 
    {
       name: "API Manager Client Applications Total", value: event.apiManagerMetrics.clients
    }++ commonFields(event ++ {group: apiManager}),     
    {
       name: "CloudHub vCores Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresTotal
    } ++ commonFields(event ++ {group: runtimeManagerCH, environmentType: envProduction}),
    {
       name: "CloudHub vCores Available Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresAvailable
    } ++ commonFields(event ++ {group: runtimeManagerCH, environmentType: envProduction}),
    {
       name: "CloudHub vCores Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.vcoresTotal
    } ++ commonFields(event ++ {group: runtimeManagerCH, environmentType: envSandbox}),
    {
       name: "CloudHub vCores Available Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.vcoresAvailable
    } ++ commonFields(event ++ {group: runtimeManagerCH, environmentType: envSandbox}),
    //This would provide a summary total of prod vcores used in the BG - removed to avoid conflict with env level total 
    // {
    //    name: "CloudHub vCores Used Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresUsed
    // } ++ commonFields(event ++ {group: runtimeManagerCH, environmentType: envProduction})
    {
       name: "RTF Fabrics Total", value: event.runtimeManagerMetrics.rtf.capacity.fabrics
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Workers Total", value: event.runtimeManagerMetrics.rtf.capacity.workers
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Controllers Total", value: event.runtimeManagerMetrics.rtf.capacity.controllers
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Cores Total", value: event.runtimeManagerMetrics.rtf.capacity.coresTotal
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Memory Total", value: event.runtimeManagerMetrics.rtf.capacity.memoryTotal
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Cores Per Fabric Average", value: event.runtimeManagerMetrics.rtf.capacity.coresPerFabric
    } ++ commonFields(event ++ {group: runtimeManagerRTF}),
    {
       name: "RTF Memory Per Fabric Average", value: event.runtimeManagerMetrics.rtf.capacity.memoryPerFabric
    } ++ commonFields(event ++ {group: runtimeManagerRTF})
    ]   //API Manager Production Metrics 
        ++ getEnvironmentApiMetrics(event.apiManagerMetrics.apis.production.details, event)
        //API Manager Sandbox Metrics 
        ++ getEnvironmentApiMetrics(event.apiManagerMetrics.apis.sandbox.details, event)
        // Runtime Manager - CloudHub Applications - Production
        ++ getChAppMetrics(event.runtimeManagerMetrics.cloudhub.applications.production.details, event)
        // Runtime Manager - CloudHub Applications - Sandbox
        ++ getChAppMetrics(event.runtimeManagerMetrics.cloudhub.applications.sandbox.details, event)
        //Runtime Manager - RTF - Production
        ++ getRtfEnvMetrics(event.runtimeManagerMetrics.rtf.applications.production.details, event)
        //Runtime Manager - RTF - Sandbox
        ++ getRtfEnvMetrics(event.runtimeManagerMetrics.rtf.applications.sandbox.details, event)
        //Runtime Manager - ARM - Production
        ++ getArmEnvMetrics(event.runtimeManagerMetrics.hybrid.production.details, event)
        //Runtime Manager - ARM - Sandbox
        ++ getArmEnvMetrics(event.runtimeManagerMetrics.hybrid.sandbox.details, event)
        //Anypoint MQ - Production
        ++ getAmqEnvMetrics(event.mqMetrics.stats.summary.production, event)
        //Anypoint MQ - Sandbox
        ++ getAmqEnvMetrics(event.mqMetrics.stats.summary.sandbox, event)
        //OSv2 - Production
        ++ getOsv2EnvMetrics(event.osV2Metrics.stats.production.details, event)
        //OSv2 - Sandbox
        ++ getOsv2EnvMetrics(event.osV2Metrics.stats.sandbox.details, event)
    )

))