%dw 2.0
output application/csv
var accessManagement = "Access Management"
var designCenter = "Design Center"
var exchange = "Exchange"
var apiManager = "API Manager"
var apiAnalytics = "API Analytics"
var runtimeManagerCH = "Runtime Manager - CloudHub"
var runtimeManagerHybrid = "Runtime Manager - ARM"
var runtimeManagerRTF = "Runtime Manager - RTF"

var envSandbox = "Sandbox"
var envProduction = "Production"
var envNA = "NA"
---
flatten (payload map ((event, eventIndex) -> ([
    //Coreservices
    {
        name: "Users Total", value: event.coreServicesMetrics.users.total,
        businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    }, 
    {
       name: "Active Users", value: event.coreServicesMetrics.users.activeMembers,
       businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    },
    {
        name: "Inactive Users", value: event.coreServicesMetrics.users.inactiveMembers,
        businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    }, 
    {
       name: "Active Users Last 60 days", value: event.coreServicesMetrics.users.activeMembersLast60Days,
       businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    },
    {
        name: "Active Users Last 30 days", value: event.coreServicesMetrics.users.activeMembersLast30Days,
        businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    }, 
    {
       name: "Environments Total", value: event.coreServicesMetrics.environments.total,
       businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    }, 
    {
       name: "Environments Production Total", value: event.coreServicesMetrics.environments.production,
       businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    }, 
    {
       name: "Environments Sandbox Total", value: event.coreServicesMetrics.environments.sandbox,
       businessGroup: event.businessGroup, date: event.date, group: accessManagement, evironmentType: envNA
    },
    //Design Center 
    {
       name: "Design Center Assets Total", value: event.designCenterMetrics.total,
       businessGroup: event.businessGroup, date: event.date, group: designCenter, evironmentType: envNA
    }, 
    {
       name: "Design Center API Specs Total", value: event.designCenterMetrics.apiSpecs,
       businessGroup: event.businessGroup, date: event.date, group: designCenter, evironmentType: envNA
    }, 
    {
       name: "Design Center Fragments Total", value: event.designCenterMetrics.fragments,
       businessGroup: event.businessGroup, date: event.date, group: designCenter, evironmentType: envNA
    }, 
    {
       name: "Design Center Flow Designer Apps Total", value: event.designCenterMetrics.flowDesignerApps,
       businessGroup: event.businessGroup, date: event.date, group: designCenter, evironmentType: envNA
    }, 
    //Exchange
    {
       name: "Exchange Assets Total", value: event.exchangeMetrics.total,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange API Specs Total", value: event.exchangeMetrics.apiSpecs,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Connectors Total", value: event.exchangeMetrics.connectors,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Fragments Total", value: event.exchangeMetrics.fragments,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange HTTP Proxies Total", value: event.exchangeMetrics.proxies,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Extensions Total", value: event.exchangeMetrics.extensions,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Extensions Total", value: event.exchangeMetrics.extensions,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Custom Assets Total", value: event.exchangeMetrics.custom,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    }, 
    {
       name: "Exchange Overall Satisfaction", value: event.exchangeMetrics.overallSatisfaction,
       businessGroup: event.businessGroup, date: event.date, group: exchange, evironmentType: envNA
    },

    //API Manager - Client Apps 
    {
       name: "API Manager Client Applications Total", value: event.apiManagerMetrics.clients,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envNA
    },
    //API Manager Production 
    {
       name: "API Manager API Specs Managed Total", value: event.apiManagerMetrics.apis.production.total,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    },
    {
       name: "API Manager API Instances Total", value: event.apiManagerMetrics.apis.production.apiInstances,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    },
    {
       name: "API Manager API Instances Active Total", value: event.apiManagerMetrics.apis.production.active,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances Inactive Total", value: event.apiManagerMetrics.apis.production.inactive,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances Versions Total", value: event.apiManagerMetrics.apis.production.apiVersions,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances With Policies Total", value: event.apiManagerMetrics.apis.production.apisWithPolicies,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances Without Policies Total", value: event.apiManagerMetrics.apis.production.apisWithoutPolicies,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances With Security Policies Total", value: event.apiManagerMetrics.apis.production.apisWithSecurity,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances Without Security Policies Total", value: event.apiManagerMetrics.apis.production.apisWithoutSecurity,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances With Contracts Total", value: event.apiManagerMetrics.apis.production.apisWithContracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances Without Contracts Total", value: event.apiManagerMetrics.apis.production.apisWithoutContracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances With More Than One Consumer Total", value: event.apiManagerMetrics.apis.production.apisWithMoreThanOneConsumer,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Instances With One or More Consumers Total", value: event.apiManagerMetrics.apis.production.apisWithOneOrMoreConsumers,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager API Contracts Total", value: event.apiManagerMetrics.apis.production.contracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager Polcies Used", value: event.apiManagerMetrics.apis.production.policiesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager Polcies Used Total", value: event.apiManagerMetrics.apis.production.policiesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager Automated Polcies Used", value: event.apiManagerMetrics.apis.production.automatedPoliciesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    {
       name: "API Manager Automated Polcies Used Total", value: event.apiManagerMetrics.apis.production.automatedPoliciesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envProduction
    }, 
    //Analytics Production
    {
       name: "API Analytics Transactions Last 30 days Total", value: event.apiManagerMetrics.apis.production.transactions,
       businessGroup: event.businessGroup, date: event.date, group: apiAnalytics, evironmentType: envProduction
    },

    //API Manager Sandbox
    {
       name: "API Manager API Specs Managed Total", value: event.apiManagerMetrics.apis.sandbox.total,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    },
    {
       name: "API Manager API Instances Total", value: event.apiManagerMetrics.apis.sandbox.apiInstances,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    },
    {
       name: "API Manager API Instances Active Total", value: event.apiManagerMetrics.apis.sandbox.active,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances Inactive Total", value: event.apiManagerMetrics.apis.sandbox.inactive,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances Versions Total", value: event.apiManagerMetrics.apis.sandbox.apiVersions,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances With Policies Total", value: event.apiManagerMetrics.apis.sandbox.apisWithPolicies,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances Without Policies Total", value: event.apiManagerMetrics.apis.sandbox.apisWithoutPolicies,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances With Security Policies Total", value: event.apiManagerMetrics.apis.sandbox.apisWithSecurity,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances Without Security Policies Total", value: event.apiManagerMetrics.apis.sandbox.apisWithoutSecurity,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances With Contracts Total", value: event.apiManagerMetrics.apis.sandbox.apisWithContracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances Without Contracts Total", value: event.apiManagerMetrics.apis.sandbox.apisWithoutContracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances With More Than One Consumer Total", value: event.apiManagerMetrics.apis.sandbox.apisWithMoreThanOneConsumer,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Instances With One or More Consumers Total", value: event.apiManagerMetrics.apis.sandbox.apisWithOneOrMoreConsumers,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager API Contracts Total", value: event.apiManagerMetrics.apis.sandbox.contracts,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager Polcies Used", value: event.apiManagerMetrics.apis.sandbox.policiesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager Polcies Used Total", value: event.apiManagerMetrics.apis.sandbox.policiesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager Automated Polcies Used", value: event.apiManagerMetrics.apis.sandbox.automatedPoliciesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    }, 
    {
       name: "API Manager Automated Polcies Used Total", value: event.apiManagerMetrics.apis.sandbox.automatedPoliciesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: apiManager, evironmentType: envSandbox
    },
    //Analytics Sandbox 
    {
       name: "API Analytics Transactions Last 30 days Total", value: event.apiManagerMetrics.apis.sandbox.transactions,
       businessGroup: event.businessGroup, date: event.date, group: apiAnalytics, evironmentType: envSandbox
    },

    //Runtime Manager - CloudHub Networking
    {
       name: "CloudHub VPCs Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },
    {
       name: "CloudHub VPCs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsAvailable,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },
    {
       name: "CloudHub VPCs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpcsUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },
    {
       name: "CloudHub VPNs Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },
    {
       name: "CloudHub VPNs Available Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsAvailable,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },
    {
       name: "CloudHub VPNs Used Total", value: event.runtimeManagerMetrics.cloudhub.networking.vpnsUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envNA
    },

    //Runtime Manager - CloudHub Applications - Production
    {
       name: "CloudHub vCores Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub vCores Available Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresAvailable,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub vCores Used Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.vcoresUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub Applications Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub Applications Started Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub Applications Stopped Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub Runtime Versions Used", value: event.runtimeManagerMetrics.cloudhub.applications.production.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },
    {
       name: "CloudHub Runtime Versions Used Total", value: event.runtimeManagerMetrics.cloudhub.applications.production.runruntimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envProduction
    },




    //Runtime Manager - CloudHub Applications - Sandbox
    {
       name: "CloudHub vCores Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.vcoresTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub vCores Available Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.vcoresAvailable,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub vCores Used Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.vcoresUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub Applications Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub Applications Started Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub Applications Stopped Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub Runtime Versions Used", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },
    {
       name: "CloudHub Runtime Versions Used Total", value: event.runtimeManagerMetrics.cloudhub.applications.sandbox.runtimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerCH, evironmentType: envSandbox
    },


    //Runtime Manager - RTF
    {
       name: "RTF Fabrics Total", value: event.runtimeManagerMetrics.rtf.capacity.fabrics,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Workers Total", value: event.runtimeManagerMetrics.rtf.capacity.workers,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Controllers Total", value: event.runtimeManagerMetrics.rtf.capacity.controllers,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Cores Total", value: event.runtimeManagerMetrics.rtf.capacity.coresTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Memory Total", value: event.runtimeManagerMetrics.rtf.capacity.memoryTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Cores Per Fabric Average", value: event.runtimeManagerMetrics.rtf.capacity.coresPerFabric,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },
    {
       name: "RTF Memory Per Fabric Average", value: event.runtimeManagerMetrics.rtf.capacity.memoryPerFabric,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envNA
    },

    //Runtime Manager - RTF - Production
    {
       name: "RTF Cores Used Total", value: event.runtimeManagerMetrics.rtf.applications.production.coresUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Memory Used Total", value: event.runtimeManagerMetrics.rtf.applications.production.memoryUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Applications Total", value: event.runtimeManagerMetrics.rtf.applications.production.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Applications Started Total", value: event.runtimeManagerMetrics.rtf.applications.production.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Applications Stopped Total", value: event.runtimeManagerMetrics.rtf.applications.production.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Runtime Versions Used", value: event.runtimeManagerMetrics.rtf.applications.production.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },
    {
       name: "RTF Runtime Versions Used Total", value: event.runtimeManagerMetrics.rtf.applications.production.runtimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envProduction
    },


    //Runtime Manager - RTF - Sandbox
    {
       name: "RTF Cores Used Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.coresUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Memory Used Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.memoryUsed,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Applications Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Applications Started Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Applications Stopped Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Runtime Versions Used", value: event.runtimeManagerMetrics.rtf.applications.sandbox.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },
    {
       name: "RTF Runtime Versions Used Total", value: event.runtimeManagerMetrics.rtf.applications.sandbox.runtimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerRTF, evironmentType: envSandbox
    },



    //Runtime Manager - ARM - Production
    {
       name: "Standalone Mule Servers Total", value: event.runtimeManagerMetrics.hybrid.production.servers,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Clusters Total", value: event.runtimeManagerMetrics.hybrid.production.clusters,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Server Groups Total", value: event.runtimeManagerMetrics.hybrid.production.serverGroups,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Applications Total", value: event.runtimeManagerMetrics.hybrid.production.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Applications Started Total", value: event.runtimeManagerMetrics.hybrid.production.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Applications Stopped Total", value: event.runtimeManagerMetrics.hybrid.production.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Runtime Versions", value: event.runtimeManagerMetrics.hybrid.production.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },
    {
       name: "Standalone Mule Runtime Versions Total", value: event.runtimeManagerMetrics.hybrid.production.runtimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envProduction
    },


    //Runtime Manager - ARM - Sandbox
    {
       name: "Standalone Mule Servers Total", value: event.runtimeManagerMetrics.hybrid.sandbox.servers,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Clusters Total", value: event.runtimeManagerMetrics.hybrid.sandbox.clusters,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Server Groups Total", value: event.runtimeManagerMetrics.hybrid.sandbox.serverGroups,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Applications Total", value: event.runtimeManagerMetrics.hybrid.sandbox.applicationsTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Applications Started Total", value: event.runtimeManagerMetrics.hybrid.sandbox.applicationsStarted,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Applications Stopped Total", value: event.runtimeManagerMetrics.hybrid.sandbox.applicationsStopped,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Runtime Versions", value: event.runtimeManagerMetrics.hybrid.sandbox.runtimesUsed joinBy " ",
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },
    {
       name: "Standalone Mule Runtime Versions Total", value: event.runtimeManagerMetrics.hybrid.sandbox.runtimesUsedTotal,
       businessGroup: event.businessGroup, date: event.date, group: runtimeManagerHybrid, evironmentType: envSandbox
    },

   ])
))
