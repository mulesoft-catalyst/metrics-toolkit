%dw 2.0
output application/json

var environments = vars.environments
var entitlements = vars.entitlements
var errors = vars.errors
---
{
	date: vars.date,
	businessGroup: vars.orgName,
	businessGroupId: vars.orgId,
	coreServicesMetrics: {
		users: {
			total: 0,
			activeMembers: 0,
			inactiveMembers: 0,
			activeMembersLast60Days: 0,  // defaulting to |2000-01-01T00:00:00.000Z| for null cases
			activeMembersLast30Days: 0  // defaulting to |2000-01-01T00:00:00.000Z| for null cases
		},
		environments: {
			total:  0,
			production: 0,
			sandbox: 0,
		}
	},
	designCenterMetrics: {
		total: 0,
		apiSpecs: 0,
		fragments: 0,
		flowDesignerApps: 0
	},
	exchangeMetrics: {
            total: 0,
		    apiSpecs: 0,
            fragments: 0,
            proxies: 0,
            soapApis: 0,
            policies: 0,
		    mule3Connectors: 0,
            extensions: 0,
            applications: 0,
		    custom: 0,
		    overallSatisfaction: 0,
        reuse: {
            // Avg of times a Fragment is imported by an API Spec
            fragments: 0,
            // Avg of times an API Spec is implemented by an Application
            // Only valid for Applications uploaded to Exchange with RAML as a dependency
            implementedApis: 0,
            // Avg of times an API Spec is managed from API Manager (Sandbox environments)
            managedSboxApis: 0,
            // Avg of times an API Spec is managed from API Manager (Production environments)
            managedProdApis: 0,
            // Avg of times a Extension is imported by an Application
            // Only valid for Applications uploaded to Exchange with RAML as a dependency
            extensions: 0,
            // Avg of times a Custom Policy is applied on API Manager (Sandbox environments)
            appliedPoliciesSbox: 0,
            // Avg of times a Custom Policy is applied on API Manager (Production environments)
            appliedPoliciesProd: 0
        }
	},
	apiManagerMetrics: {
		clients: 0,
		apis: {
			production: {
				total: 0,
				active: 0,
				inactive: 0,
				apiInstances: 0, 
				apiVersions: 0,
				apisWithPolicies: 0,
				apisWithoutPolicies: 0 ,
				apisWithSecurity:  0,
				apisWithoutSecurity: 0, 
				apisWithContracts: 0,
				apisWithoutContracts: 0,
				apisWithMoreThanOneConsumer: 0,
				apisWithOneOrMoreConsumers: 0,
				contracts: 0,
				policiesUsed: [],
				policiesUsedTotal: 0,
				automatedPoliciesUsed: [],
				automatedPoliciesUsedTotal: 0,
				transactions: 0, //last x days on the period collected
				details: []
			},
			sandbox: {
				total: 0,
				active: 0,
				inactive: 0,
				apiInstances: 0, 
				apiVersions: 0,
				apisWithPolicies: 0,
				apisWithoutPolicies: 0 ,
				apisWithSecurity:  0,
				apisWithoutSecurity: 0, 
				apisWithContracts: 0,
				apisWithoutContracts: 0,
				apisWithMoreThanOneConsumer: 0,
				apisWithOneOrMoreConsumers: 0,
				contracts: 0,
				policiesUsed: [],
				policiesUsedTotal: 0,
				automatedPoliciesUsed: [],
				automatedPoliciesUsedTotal: 0,
				transactions: 0, //last x days on the period collected
				details: []
			}	
		}	
	},
	runtimeManagerMetrics: {
		cloudhub: {
			networking: {
				vpcsTotal: 0,
				vpcsAvailable: 0,
				vpcsUsed: 0,
				vpnsTotal: 0,
				vpnsAvailable: 0,
				vpnsUsed: 0,
				dlbsTotal: 0,
				dlbsAvailable: 0,
				dlbsUsed: 0,
				staticIPsTotal: 0,
				staticIPsAvailable: 0,
				staticIPsUsed: 0
			},
			
			applications:{
				production: {
					vcoresTotal: 0,
					vcoresAvailable: 0,
					vcoresUsed: 0,
					applicationsTotal: 0,
					applicationsStarted: 0,
					applicationsStopped: 0,
					runtimesUsed: [],
					runtimesUsedTotal: 0,
					details: []
				},
				sandbox:{
					vcoresTotal: 0,
					vcoresAvailable: 0,
					vcoresUsed: 0,
					applicationsTotal: 0,
					applicationsStarted: 0,
					applicationsStopped: 0,
					runtimesUsed: [],
					runtimesUsedTotal: 0,
					details: []
				}
			}
		},
		rtf: {
			capacity: {
					fabrics: 0,
    				workers: 0,
    				controllers: 0,
    				coresTotal: 0,
   				    memoryTotal: 0,
    				coresPerFabric:  0,
    				memoryPerFabric: 0
			},
			applications: {
				production: {
					//coresAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					//coresUsed: sum((flatten(getProdDetails(armApps) default []).target.deploymentSettings.resources.cpu.limit  map (($ replace  "m" with "") as Number)) default [])/1000, //cores
					coresUsed: 0,
					coresReserved: 0,
					//memoryAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					memoryUsed: 0, //Gigs
					applicationsTotal: 0,
					applicationsStarted: 0,
					applicationsStopped: 0,
					runtimesUsed: [],
					runtimesUsedTotal: 0,
					details: []
					
					
				},
				sandbox:{
					//coresAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					//coresUsed: sum((flatten(getProdDetails(armApps) default []).target.deploymentSettings.resources.cpu.limit  map (($ replace  "m" with "") as Number)) default [])/1000, //cores
					coresUsed: 0,
					coresReserved: 0,
					//memoryAvailable: "NA", // Not able to calculate because a fabric can be associated with multiple environments of any type
					memoryUsed: 0, //Gigs
					applicationsTotal: 0,
					applicationsStarted: 0,
					applicationsStopped: 0,
					runtimesUsed: [],
					runtimesUsedTotal: 0,
					details: []
				}	
			}
		},
		hybrid: {
			production: {
				servers: 0,
				clusters: 0,
				serverGroups: 0,
				applicationsTotal: 0,
				applicationsStarted: 0,
				applicationsStopped: 0,
				runtimesUsed: [],
				runtimesUsedTotal: 0,
				details: []
			},
			sandbox:{
				servers: 0,
				clusters: 0,
				serverGroups: 0,
				applicationsTotal: 0,
				applicationsStarted: 0,
				applicationsStopped: 0,
				runtimesUsed: [],
				runtimesUsedTotal: 0,
				details: []
			}
		}	
	},
	"mqMetrics": {
        "stats": {
            "summary": {
                "production": {
                    "queues": {
                        "commonQueues": 0,
                        "fifoQueues": 0,
                        "messagesInFlight": 0,
                        "messagesSent": 0,
                        "messagesReceived": 0,
                        "messagesAck": 0,
                        "details": []
                    },
                    "exchanges": {
                        "exchangeQueues": 0,
                        "messagesPublished": 0,
                        "messagesDelivered": 0,
                        "details": []
                    }
                },
                "sandbox": {
                    "queues": {
                        "commonQueues": 0,
                        "fifoQueues": 0,
                        "messagesInFlight": 0,
                        "messagesSent": 0,
                        "messagesReceived": 0,
                        "messagesAck": 0,
                        "details": []
                    },
                    "exchanges": {
                        "exchangeQueues": 0,
                        "messagesPublished": 0,
                        "messagesDelivered": 0,
                        "details": []
                    }
                }
            },
            "byRegion": {
                "production": [
                    {
                        "id": "us-east-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "us-west-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ca-central-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "eu-west-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "eu-west-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ap-southeast-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ap-southeast-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    }
                ],
                "sandbox": [
                    {
                        "id": "us-east-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "us-west-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ca-central-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "eu-west-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "eu-west-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ap-southeast-1",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    },
                    {
                        "id": "ap-southeast-2",
                        "queues": {
                            "commonQueues": 0,
                            "fifoQueues": 0,
                            "messagesInFlight": 0,
                            "messagesSent": 0,
                            "messagesReceived": 0,
                            "messagesAck": 0
                        },
                        "exchanges": {
                            "exchangeQueues": 0,
                            "messagesPublished": 0,
                            "messagesDelivered": 0
                        }
                    }
                ]
            }
        }
    },
    "osV2Metrics": {
        "stats": {
            "production": {
                "requestCount": 0,
                "details": []
            },
            "sandbox": {
                "requestCount": 0,
                "details": []
            }
        }
    },
	errors: errors	
}
