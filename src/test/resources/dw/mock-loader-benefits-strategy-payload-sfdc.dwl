%dw 2.0
output application/json
---
{
	event: {
		date: "2020-02-19T00:11:34.341-08:00",
		businessGroup: "Any",
		developAPIHistoricTime: 20,
		developAPICurrentTime: 4,
		maintainAPIHistoricTime: 20,
		maintainAPICurrentTime: 1,
		developerDayRate: 500	
	},
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