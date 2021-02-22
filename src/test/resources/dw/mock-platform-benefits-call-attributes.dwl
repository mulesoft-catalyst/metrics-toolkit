%dw 2.0
output application/java
---
{
	headers: {
		"X-ANYPNT-ORG-ID": "877baaaa-36ba-4021-82d5-45bae78e0fe2",
		"X-ANYPNT-USERNAME": "mthemule",
		"X-ANYPNT-PASSWORD": "ThisIsASuperSecureMockedPassword",
		"Authorization": "",
		
	},
	queryParams: {
		developAPIHistoricTime:20,
		developAPICurrentTime:10,
		maintainAPIHistoricTime:15,
		maintainAPICurrentTime:7,
		developerDayRate:200
	}
}