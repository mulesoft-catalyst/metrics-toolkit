%dw 2.0
output application/json
var bitbucketData = payload[0].payload default []
var confluenceData = payload[1].payload default []
var jenkinsData = payload[2].payload default []
var jiraData = payload[3].payload[0].payload default []
var jiraBacklogData = payload[3].payload[1].payload default []
var splunkData = payload[4].payload default []
var azureDevOpsBacklogData = payload[5].payload[0].payload default []
var azureDevOpsSprintData = payload[5].payload[1].payload default []
var azureDevOpsBuildData = payload[5].payload[2].payload default []
var azureDevOpsRepoData = payload[5].payload[3].payload default []
---
{
	date: vars.date,
	sdlcMetrics: {
		bitBucketMetrics: if(vars.sdlcDetails.bitbucket.enabled == "true") {
			totalRepositories: bitbucketData.size default null
		} else {
		},
		confluenceMetrics: if(vars.sdlcDetails.confluence.enabled == "true") {
			totalPages: confluenceData.size default null,
			totalPagesCreatedInLast30Days : sizeOf(confluenceData.results filter ($.history.createdDate as String {format: "uuuu-MM-dd'T'HH:mm:ss.SSS"} as Date) > now() - |P30D|) default null,
			totalPagesUpdatedInLast30Days : sizeOf(confluenceData.results filter ($.history.lastUpdated.when as String {format: "uuuu-MM-dd'T'HH:mm:ss.SSS"} as Date) > now() - |P30D|) default null,
			topContributorsInLast30Days : ((confluenceData.results filter ($.history.createdDate as String {format: "uuuu-MM-dd'T'HH:mm:ss.SSS"} as Date) > now() - |P30D| groupBy $.history.createdBy.publicName) mapObject {
				($$) : sizeOf($)
			} orderBy (-$)) default null
		} else {},
		jenkinsMetrics: if(vars.sdlcDetails.jenkins.enabled == "true") {
			totalJobs : sizeOf(jenkinsData.jobs)  default null,
			totalFailedJobs : sizeOf(jenkinsData.jobs filter $.color == "red") default null,
			totalSuccessJobs : sizeOf(jenkinsData.jobs filter $.color == "blue")  default null,
			totalUnexecutedJobs : sizeOf(jenkinsData.jobs filter $.color == "notbuilt")  default null
		} else {},
		jiraMetrics: if(vars.sdlcDetails.jira.enabled == "true") {
			totalJiraTasksInBacklog: jiraBacklogData.total default null,
    		totalJiraTasksInSprint : jiraData.total,
    		totalJiraTasksByType : (jiraData.issues groupBy $.fields.issuetype.name) mapObject  {($$) : sizeOf($)} default null,
    		totalJiraTasksByStatus : (jiraData.issues groupBy $.fields.status.name) mapObject  {($$) : sizeOf($)} default null
		} else {},
		splunkMetrics: if(vars.sdlcDetails.splunk.enabled == "true") {
			totalDashboards: splunkData
		} else {},
		azuredevopsMetrics: if(vars.sdlcDetails.azuredevops.enabled == "true") {
			totalTasksInBacklog: sizeOf(azureDevOpsBacklogData) default null,
    		totalTasksInSprint : sizeOf(azureDevOpsSprintData) default null,
    		totalTasksByType : (azureDevOpsSprintData groupBy $.taskType) mapObject  {($$) : sizeOf($)} default null,
    		totalTasksByStatus : (azureDevOpsSprintData groupBy $.status) mapObject  {($$) : sizeOf($)} default null,
            totalRepositories: azureDevOpsRepoData.size,
            totalJobs: sizeOf(azureDevOpsBuildData),
            totalFailedJobs: sizeOf(azureDevOpsBuildData filter() -> $.result == "failed"),
            totalSuccessJobs: sizeOf(azureDevOpsBuildData filter() -> $.result == "succeeded"),
            totalUnexecutedJobs: sizeOf(azureDevOpsBuildData filter() -> $.result == "no runs")
		} else {},
		errors: vars.errors
	} filterObject (!isEmpty($))
}
