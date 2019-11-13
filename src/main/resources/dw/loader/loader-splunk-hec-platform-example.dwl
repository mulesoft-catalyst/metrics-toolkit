%dw 2.0
output application/json
---
[
	{
		businessGroup: "anotherBG",
		coreServicesMetrics: {
			users: {
				total: 45,
				activeMembers: 20,
				inactiveMembers: 25,
				activeMembersLast60Days: 15
			},
			environments: {
				total: 8,
				production: 2,
				sandbox: 6
			}
		},
		designCenterMetrics: {
			total: 32,
			apiSpecs: 17,
			fragments: 13,
			flowDesignerApps: 2
		},
		exchangeMetrics: {
			total: 40,
			apiSpecs: 15,
			connectors: 15,
			fragments: 6,
			proxies: 2,
			extensions: 2,
			custom: 0,
			overallSatisfaction: 5		
		},
		apiManagerMetrics: {
			clients: 40,
			apis: {
				production: {
					total: 20,
					active: 18,
					inactive: 2,
					apiInstances: 19,
					apiVersions: 3,
					apisWithPolicies: 10,
					apisWithoutPolicies: 10,
					apisWithSecurity: 18,
					apisWithoutSecurity:2, 
					apisWithContracts: 20,
					apisWithoutContracts: 0,
					apisWithMoreThanOneConsumer: 5,
					apisWithOneOrMoreConsumers: 10,
					contracts: 12,
					policiesUsed: ["policyA","policyB","policyC"],
					policiesUsedTotal: 3,
					transactions: 8000 //last x days on the period collected
				
				},
				sandbox: {
					total: 40,
					active: 38,
					inactive: 2,
					apiInstances: 19,
					apiVersions: 3,
					apisWithPolicies: 20,
					apisWithoutPolicies: 20,
					apisWithSecurity: 38,
					apisWithoutSecurity:2, 
					apisWithContracts: 40,
					apisWithoutContracts: 0,
					apisWithMoreThanOneConsumer: 5,
					apisWithOneOrMoreConsumers: 10,
					policiesUsed: ["policyA","policyB","policyC"],
					policiesUsedTotal: 3,
					contracts: 60,
					transactions: 8000 //last x days on the period collected
				}	
			}	
		},
		runtimeManagerMetrics: {
			cloudhub: {
				networking: {
					vpcsTotal: 2,
					vpcsAvailable: 0,
					vpcsUsed: 2,
					vpnsTotal: 4,
					vpnsAvailable: 2,
					vpnsUsed: 2
				},
				applications:{
					production: {
						vcoresTotal: 20,
						vcoresAvailable: 5,
						vcoresUsed: 15,
						applicationsTotal: 55,
						applicationsStarted: 50,
						applicationsStopped: 5,
						runtimesUsed: ["4.2.1","3.9.1"],
						runtimesUsedTotal: 2
					},
					sandbox:{
						vcoresTotal: 30,
						vcoresAvailable: 5,
						vcoresUsed: 25,
						applicationsTotal: 70,
						applicationsStarted: 67,
						applicationsStopped: 3,
						runtimesUsed: ["4.2.1","3.9.1"],
						runtimesUsedTotal: 2
					}
				}
			},
			rtf: {
				production: {
					fabrics: 2,
					coresTotal: 40,
					coresAvailable: 10, //cores
					coresUsed: 30, //cores
					memoryTotal: 180,
					memoryAvailable: 80, //Gigs
					memoryUsed: 100, //Gigs
					applicationsTotal: 1,
					applicationsStarted: 1,
					applicationsStopped: 0,
					runtimesUsed: ["4.2.1","3.9.1"],
					runtimesUsedTotal: 2
				},
				sandbox:{
					fabrics: 1,
					coresTotal: 20,
					coresAvailable: 0, //cores
					coresUsed: 20, //cores
					memoryTotal: 80,
					memoryAvailable: 0, //Gigs
					memoryUsed: 80, //Gigs
					applicationsTotal: 5,
					applicationsStarted: 5,
					applicationsStopped: 0,
					runtimesUsed: ["4.2.1","3.9.1"],
					runtimesUsedTotal: 2
				}
			},
			hybrid: {
				production: {
					servers: 1,
					clusters: 2,
					serverGroups: 2,
					applicationsTotal: 0,
					applicationsStarted: 0,
					applicationsStopped: 0,
					runtimesUsed: ["4.2.1","3.9.1"],
					runtimesUsedTotal: 2
				},
				sandbox:{
					servers: 4,
					clusters: 3,
					serverGroups: 1,
					applicationsTotal: 10,
					applicationsStarted: 9,
					applicationsStopped: 1,
					runtimesUsed: ["4.2.1","3.9.1"],
					runtimesUsedTotal: 2
				}
			}
			
		}	
	}
]