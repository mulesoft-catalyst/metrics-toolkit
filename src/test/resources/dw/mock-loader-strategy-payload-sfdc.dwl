%dw 2.0
output application/json
---
{
	"loaderDetails": {
		"strategy": "sfdc",
		"rawData": "false",
        "sfdc": {
            "dataSetName" : "my_dataset",
            "appName": "my_data_app",
            "username": "test-user@salesforce.com",
            "password": "test-password123",
            "securityToken": "random-token-456"
        }
	}
}