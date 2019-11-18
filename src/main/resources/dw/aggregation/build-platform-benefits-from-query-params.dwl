%dw 2.0
output application/java
---
{
	developAPIHistoricTime: attributes.queryParams.developAPIHistoricTime,
	developAPICurrentTime: attributes.queryParams.developAPICurrentTime,
	developerDayRate: attributes.queryParams.developerDayRate,
	maintainAPICurrentTime: attributes.queryParams.maintainAPICurrentTime,
	maintainAPIHistoricTime: attributes.queryParams.maintainAPIHistoricTime
}