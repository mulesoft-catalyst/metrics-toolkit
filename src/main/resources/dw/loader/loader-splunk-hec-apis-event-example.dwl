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
		apiName: "my-api"
	},
	{
		organizationId: "12345",
		organizationName: "Master Org",
		environmentId: "123",
		environmentName: "Production",
		environmentType: "Production",
		isProductionEnvironment: true,
		apiName: "cases-api"
	}
]