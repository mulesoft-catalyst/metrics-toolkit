%dw 2.0
output application/json
---
{
	//time: now().milliseconds,
	source: vars.loaderDetails.splunk.source,
	sourcetype: vars.loaderDetails.splunk.sourceType,
	index: vars.index,
	event: vars.event
}