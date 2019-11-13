%dw 2.0
output application/json
---
[
	{
		organizationId: "12345",
		organizationName: "Master Org",
		environmentId: "123",
		environmentName: "Production",
		environmentType: "Production",
		isProductionEnvironment: true,
		deploymentType: "RTF",
		artifactFileName: "app1",
		workerSize: "0.1",
		workers: "2",
		memory: "8" //Gb
	},
	{
		organizationId: "12345",
		organizationName: "Master Org",
		environmentId: "123",
		environmentName: "UAT",
		environmentType: "Sandbox",
		isProductionEnvironment: true,
		deploymentType: "CH",
		artifactFileName: "app1-test",
		workerSize: "0.1",
		workers: "2"	,
		memory: "NA" //Gb
	}
]