%dw 2.0
output application/java
---
{
	headers: {
		"x-anypnt-org-id": "877baaaa-36ba-4021-82d5-45bae78e0fe2",
		"x-anypnt-username": "mthemule",
		"x-anypnt-password": "ThisIsASuperSecureMockedPassword",
		"x-plaintext-password": true,
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