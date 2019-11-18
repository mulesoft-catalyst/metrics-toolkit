%dw 2.0
output application/json
---
{
	//time: now().milliseconds,
	source: vars.loaderDetails.source,
	sourcetype: vars.loaderDetails.sourceType,
	index: vars.loaderDetails.index,
	event: vars.event
}