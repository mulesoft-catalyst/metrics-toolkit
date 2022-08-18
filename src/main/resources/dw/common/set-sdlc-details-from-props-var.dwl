%dw 2.0
output application/java
---
{
	bitbucket: {
		enabled: p('sdlc.bitbucket.enabled')
	},
	jira: {
		enabled: p('sdlc.jira.enabled')
	},
	confluence: {
		enabled: p('sdlc.confluence.enabled')
	},
	jenkins: {
		enabled: p('sdlc.jenkins.enabled')
	},
	splunk: {
		enabled: p('sdlc.splunk.enabled')
	},
	azuredevops: {
		enabled: p('sdlc.azuredevops.enabled')
	}
	
}