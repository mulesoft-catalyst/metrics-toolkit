%dw 2.0
output application/json
---
{
	//time: now().milliseconds,
	source: p('splunk.source'),
	sourcetype: p('splunk.source.type'),
	index: vars.index,
	event: vars.event
}