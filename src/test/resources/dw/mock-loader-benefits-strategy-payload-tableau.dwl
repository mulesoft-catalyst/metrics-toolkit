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
	loaderDetails: {
		strategy: "tableau",
		rawData: "false",
		tableau: {
			outputDir: "/tmp/test"	
		}	
	}
}