%dw 2.0
output application/json
var bitbucketData = payload[0].payload
var confluenceData = payload[1].payload
var jenkinsData = payload[2].payload
var jiraData = payload[3].payload
var splunkData = payload[4].payload
var azureDevOpsData = payload[5].payload
---
{
	date: vars.date,
	sdlcData : {
		bitbucketData: bitbucketData,
		confluenceData: confluenceData,
		jenkinsData: jenkinsData,
		jiraData: jiraData,
		splunkData: splunkData,
		azureDevOpsData: azureDevOpsData,
		errors: vars.errors	
		}	filterObject (!isEmpty($))
}
