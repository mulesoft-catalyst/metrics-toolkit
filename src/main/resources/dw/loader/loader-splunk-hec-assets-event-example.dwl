%dw 2.0
output application/json
---
[
	{
		organizationId: "12345",
		organizationName: "Master Org",
		assetName: "my-api",
		assetType: "rest-api"
	},
	{
		organizationId: "12345",
		organizationName: "Master Org",
		assetName: "data-type-abc",
		assetType: "raml-fragment"
	}
]